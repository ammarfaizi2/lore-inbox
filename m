Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTJ0VM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTJ0VM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:12:57 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:28547
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263652AbTJ0VMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:12:54 -0500
Date: Mon, 27 Oct 2003 16:10:18 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Hakona Spect <ear22@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 4Gb memory?
In-Reply-To: <BAY7-F103askCcBONAA0000a470@hotmail.com>
Message-ID: <Pine.LNX.4.53.0310271608570.21953@montezuma.fsmlabs.com>
References: <BAY7-F103askCcBONAA0000a470@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Hakona Spect wrote:

> Hi, I just installed 4GB memory to my system. In BIOS it shows up all 8x512M 
> chips. But after boot it shows:
> 
> $ free
>              total       used       free     shared    buffers     cached
> Mem:       3753328     566800    3186528          0      96040     189960
> -/+ buffers/cache:     280800    3472528
> Swap:      2096440          0    2096440
> 
> $dmesg
> Linux version 2.4.22 (root) (gcc version 3.2.2 20030222 (Red Hat Linux 
> 3.2.2-5)) #1 SMP Mon Oct 27 12:44:16 EST 2003
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000007ff77000 (usable)
> BIOS-e820: 000000007ff77000 - 000000007ff79000 (ACPI NVS)
> BIOS-e820: 000000007ff79000 - 00000000e7f77000 (usable)
> BIOS-e820: 00000000e7f79000 - 00000000e8000000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> user-defined physical RAM map:
> user: 0000000000000000 - 00000000000a0000 (usable)
> user: 00000000000f0000 - 0000000000100000 (reserved)
> user: 0000000000100000 - 000000007ff77000 (usable)
> user: 000000007ff77000 - 000000007ff79000 (ACPI NVS)
> user: 000000007ff79000 - 00000000e7f77000 (usable)
> user: 00000000e7f79000 - 00000000e8000000 (reserved)
> user: 00000000fec00000 - 00000000fec10000 (reserved)
> user: 00000000fee00000 - 00000000fee10000 (reserved)
> user: 00000000ffb00000 - 0000000100000000 (reserved)
> 2815MB HIGHMEM available.
> 896MB LOWMEM available.

Which motherboard? Some boards will reserve some of the area between ~3.7 
and 4G for various option roms and other devices present in the system. 
Resulting in "lost" physical RAM.

