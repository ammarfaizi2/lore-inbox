Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVBBO11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVBBO11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVBBO10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:27:26 -0500
Received: from pat.uio.no ([129.240.130.16]:30857 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262575AbVBBO1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:27:18 -0500
Date: Wed, 2 Feb 2005 15:21:55 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
Message-ID: <20050202142155.GA2764@s>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.05, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Dick Johnson]

> On Wed, 2 Feb 2005, Haakon Riiser wrote:
> 
>> How can I use a frame buffer driver's optimized copyarea, fillrect,
>> blit, etc. from userspace?  The only way I've ever seen anyone use
>> the frame buffer device is by mmap()ing it and doing everything
>> manually in the mapped memory.  I assume there must be ioctls for
>> accessing the accelerated functions, but after several hours of
>> grepping and googling, I give up. :-(
> 
> X-Windows already does this.

Yeah, I thought the X11 fbdev driver supported acceleration, but not
according to its manpage:

  fbdev is an Xorg driver for framebuffer devices.  This is a
  non-accelerated driver [...]

-- 
 Haakon
