Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUIJLhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUIJLhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUIJLhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:37:19 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:59618 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S267356AbUIJLhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:37:18 -0400
Message-ID: <4141928C.80908@drzeus.cx>
Date: Fri, 10 Sep 2004 13:39:56 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ISA DMA demand mode
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ISA DMA routines only have predefined constants for doing single DMA 
transfers. Is there some reason why one shouldn't use demand transfers? 
Hard coding DMA controller flags into my driver just feels wrong.

--
Pierre Ossman

