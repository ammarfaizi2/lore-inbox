Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUIHVZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUIHVZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbUIHVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:25:26 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:29388 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268111AbUIHVZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:25:25 -0400
Message-ID: <413F7960.8070500@drzeus.cx>
Date: Wed, 08 Sep 2004 23:28:00 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ISA DMA
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to figure out how to do ISA DMA transfers. I can't figure out 
  how to satisfy all the requirements the ISA DMA controller sets. I've 
set a DMA mask of 0x00ffffff but mappings end up above the 16MB limit 
nonetheless. And I have no idea how to keep transfers within the same 
64k boundary.

I've been trying to figure out how other drivers do it but I can't see 
what I'm missing. And the documentation doesn't cover ISA DMA.

I'm basically stuck now so I'd appreciate any tips you can give me.

Rgds
Pierre Ossman
