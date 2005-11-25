Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVKYWrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVKYWrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVKYWrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:47:01 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:4305 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932707AbVKYWrA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:47:00 -0500
Date: Fri, 25 Nov 2005 23:46:12 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp resume from dm-crypt over lvm?
Message-ID: <20051125224612.GA4304@hardeman.nu>
References: <20051124215806.GA8086@hardeman.nu> <43864C0F.1090403@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <43864C0F.1090403@domdv.de>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 12:26:07AM +0100, Andreas Steinmetz wrote:
>David Härdeman wrote:
>> Using the ability to echo the major:minor to /sys/power/resume from an
>> initramfs script I am able to resume from a lvm partition.
>> 
>> However, this doesn't seem to work if the swap partition is encrypted
>> and setup using cryptsetup (dm-crypt over an lvm partition that is).
>> 
>> Is this supposed to work or is it not feasible?
>
>See Documentation/power/swsusp-dmcrypt.txt. Works for me.

Thanks, that helped...I had missed that the device must have the same 
major/minor when resuming as it had when suspending.

Re,
David
