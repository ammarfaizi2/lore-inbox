Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVBOQF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVBOQF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVBOQF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:05:26 -0500
Received: from ns.suse.de ([195.135.220.2]:3042 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261767AbVBOQFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:05:19 -0500
Message-ID: <42121DB0.8080602@suse.de>
Date: Tue, 15 Feb 2005 17:05:04 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <200502150605.11683.s0348365@sms.ed.ac.uk>
In-Reply-To: <200502150605.11683.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Monday 14 Feb 2005 21:11, Pavel Machek wrote:
> [snip]
>>Table of known working systems:
>>
>>Model                           hack (or "how to do it")
>>---------------------------------------------------------------------------
>>--- IBM TP R32 / Type 2658-MMG      none (1)
>>Athlon HP Omnibook XE3		none (1)
>>Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
>>IBM t41p			none (1)
>>Athlon64 desktop prototype	s3_bios (2)
>>HP NC6000			s3_bios (2)
> 
> The above report is incorrect. On 2.6.11-rc4, even with the s3_bios option, 
> the NC6000 (which I own) still does not wake up from S3 sleep. The wiki 
> linked somewhere else in this thread also identifies these machines as not 
> working.

I just retried it with a nc6000, it worked with "vga=normal
acpi_sleep=s3_bios rw init=/bin/bash".
It did not work from a full blown system including X etc, but this is
probably a driver problem, the machine was sitting in a docking station
which connects everything via USB. Sorry, right now i cannot debug this
further, but it basically works and should not be too hard to get going.

Also, it does not work with vesafb (I have not tried radeonfb)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
