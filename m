Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUIINZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUIINZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUIINZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:25:33 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:50661 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263626AbUIINZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:25:31 -0400
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97 
	patch)
From: Ian Campbell <ijc@hellion.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040909114747.GC30162@lkcl.net>
References: <20040909114747.GC30162@lkcl.net>
Content-Type: text/plain
Message-Id: <1094736327.22994.9.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 14:25:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 12:47, Luke Kenneth Casson Leighton wrote:

> i trust that someone will download, check it, and if
> appropriate, incorporate it into the mainstream linux kernel.

The ALSA bit is already in the kernel at sound/pci/intel8x0m.c, I don't
know when it was added though. Not sure of the status of the USB bit,
but I think it is normally up to the author to submit something rather
than some 3rd party...

Unfortunately the ALSA driver doesn't work for me, I just get NO
DIALTONE and the following in the kernel logs:

        codec_semaphore: semaphore is not ready [0x1][0x300300]
        codec_write 1: semaphore is not ready for register 0x54
        
I only tried it out last night, and I don't really need the modem in my
laptop much (it never really travels much further than the sofa :) so I
haven't really investigated much.

The laptop is a VAIO from several years ago. lspci shows the modem as:
0000:00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev 03)

Ian.
-- 
Ian Campbell
Current Noise: Dream Theater - About to Crash

Q:	Why did the lone ranger kill Tonto?
A:	He found out what "kimosabe" really means.

