Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVE1Ni3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVE1Ni3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 09:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVE1Ni2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 09:38:28 -0400
Received: from [85.8.12.41] ([85.8.12.41]:28336 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262721AbVE1Ni1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 09:38:27 -0400
Message-ID: <42987450.9000601@drzeus.cx>
Date: Sat, 28 May 2005 15:38:24 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: ISA DMA controller hangs
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having some problems with ISA DMA transfers failing. They work
fine until the machine does a suspend-to-ram. After that all DMA
transfers stall. Does perhaps the DMA controller need a kick in the ***
after a suspend? I'm no expert on the ISA DMA controller so I could use
some help here.

Rgds
Pierre
