Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVKSFFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVKSFFx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 00:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKSFFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 00:05:53 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19615 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750914AbVKSFFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 00:05:52 -0500
Date: Fri, 18 Nov 2005 23:05:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Compaq Presario "reboot" problems
In-reply-to: <59X9C-2Va-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <437EB2A1.10905@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <59X9C-2Va-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> With Linux-2.4.26 I reported that if a Compaq gets rebooted while
> running Linux-2.4.26, it will not be able to restart Windows 2000.
> It cam restart Linux fine. Today, I tried the same thing with
> Linux-2.6.13.4. It fails, too.
> 
> The symptoms are that you just "reboot" Linux. When the GRUB loader
> comes up, I select my Windows-2000/professional. That M$ Crap comes
> up to where it's just about to start the high-resolution screen.
> Then it stops forever, no interrupts, no nothing. I need to disconnect
> power and remove the battery to recover.
> 
> It appears as though Linux is still restarting as a "warm boot",
> rather than a cold boot (in other words, putting magic in the
> shutdown byte of CMOS) so the hardware doesn't get properly
> initialized. Would somebody please check this out. When changing
> operating systems, you need a cold-boot.

This sounds more like the BIOS is not properly reinitializing all 
hardware and expects it to be in some state which Linux does not leave 
it in. BIOS update available?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

