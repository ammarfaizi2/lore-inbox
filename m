Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282398AbRKXIDm>; Sat, 24 Nov 2001 03:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282399AbRKXIDc>; Sat, 24 Nov 2001 03:03:32 -0500
Received: from lacutis.anu.edu.au ([150.203.193.28]:47006 "EHLO lacutis")
	by vger.kernel.org with ESMTP id <S282398AbRKXIDV>;
	Sat, 24 Nov 2001 03:03:21 -0500
Date: Sat, 24 Nov 2001 19:04:12 +1100
From: Patrick Cole <z@amused.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No recording on maestro3 (hp omnibook xe3)
Message-ID: <20011124190412.A14605@wapcaplet>
In-Reply-To: <20011124003330.A106@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011124003330.A106@elf.ucw.cz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Nov 24, 2001 at 12:33:31AM +0100, Pavel Machek wrote:

> When I do cat /dev/dsp, I get no data, and 
> 
> Nov 24 00:31:55 amd kernel: read: chip lockup? dmasz 65536 fragsz 64 count 0 hwptr 0 swptr 0
> Nov 24 00:31:58 amd last message repeated 3 times
> 
> in the log. Is there way to help me? linux 2.4.14

Well my maestro3 works fine recording; cat /dev/dsp gives lots of rubbish.
I have however noticed that on odd occasion it just stops working (no playing
or nothing.. totally dead) and a reboot is required to get functionality back. 
Anyone had this problem before? 

This is the maestro3 from the Inspiron 8100.  Here is the relevant data:

maestro3: version 1.22 built at 20:12:16 Nov 13 2001
PCI: Found IRQ 5 for device 02:03.0
maestro3: Configuring ESS Maestro3(i) found at IO 0xEC00 IRQ 5
maestro3:  subvendor id: 0x00e61028

Sep 30 23:32:31 jaded kernel: read: chip lockup? dmasz 65536 fragsz 64 count 0 hwptr 19808 swptr 19808
Sep 30 23:32:32 jaded kernel: read: chip lockup? dmasz 65536 fragsz 64 count 0 hwptr 19808 swptr 19808

Cheers,

  Patrick

