Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVBBPmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVBBPmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVBBPmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:42:05 -0500
Received: from pat.uio.no ([129.240.130.16]:35833 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262294AbVBBPly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:41:54 -0500
Date: Wed, 2 Feb 2005 16:41:39 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
Message-ID: <20050202154139.GA3267@s>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com> <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1107357093.6191.53.camel@gonzales>
User-Agent: Mutt/1.5.6i
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.05, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Xavier Bestel]

> Le mercredi 02 février 2005 à 15:21 +0100, Haakon Riiser a
> écrit :

>> How can I use a frame buffer driver's optimized copyarea,
>> fillrect, blit, etc. from userspace?  The only way I've ever
>> seen anyone use the frame buffer device is by mmap()ing it
>> and doing everything manually in the mapped memory.  I assume
>> there must be ioctls for accessing the accelerated functions,
>> but after several hours of grepping and googling, I give up. :-(

> Did you try DirectFB ?

Thanks for the tip, I hadn't heard about it.  I will take a look,
but only to see if it can show me the user space API of /dev/fb.
I don't need a general library that supports a bunch of different
graphics cards.  I'm writing my own frame buffer driver for the
GX2 CPU, and I just want to know how to call the various functions
registered in struct fb_ops, so that I can test my code.  I mean,
all those functions registered in fb_ops must be accessible
somehow; if they weren't, what purpose would they serve?

-- 
 Haakon
