Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267045AbUBFBPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267073AbUBFBPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:15:40 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:31675 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S267045AbUBFBPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:15:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Azog <slashmail@arnor.net>
Subject: Re: [2.6 patch] remove USB_SCANNER
Date: Thu, 5 Feb 2004 20:15:22 -0500
User-Agent: KMail/1.6
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@fs.tum.de>,
       Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
References: <20040126215036.GA6906@kroah.com> <20040205011423.GA6092@kroah.com> <1076001658.3225.101.camel@moria.arnor.net>
In-Reply-To: <1076001658.3225.101.camel@moria.arnor.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402052015.22926.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.53.166] at Thu, 5 Feb 2004 19:15:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 February 2004 12:20, Azog wrote:
>On Wed, 2004-02-04 at 17:14, Greg KH wrote:
>> On Thu, Feb 05, 2004 at 01:31:36AM +0100, Adrian Bunk wrote:
>
>[...]
>
>> > If not, please apply the patch below plus do a
>> >   rm drivers/usb/image/scanner.{c,h}
>>
>> I've applied this patch, and removed the driver from the kernel.
>
>(sigh) Just last night I had to reboot into 2.4 to use my new USB
>scanner.
>
>I tried for a while to get it working under 2.6.  I'm not exactly a
>beginner at this stuff either.
>
>With 2.4 it took less than 30 seconds and worked perfectly,
> following the SANE documentation instructions.  My user space is
> Fedora Core 1 with all available updates.
>
>So, what are you all using / recommending for user space
> configuration and control of a USB scanner under 2.6?
>
>http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt doesn't say
> a word about USB scanners, and I havn't seen the issue mentioned
> anywhere else either.
>
I dunno what the problem might be on your mobo, but here, the latest 
version of libusb (1.7 I believe) "just works" with virtually any 2.6 
kernel so far.  You may want to turn on the verbose debugging in 
your .config file, rebuild and reboot.  It might be educational.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
