Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSIHVw7>; Sun, 8 Sep 2002 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSIHVw7>; Sun, 8 Sep 2002 17:52:59 -0400
Received: from ns1.ionium.org ([62.27.22.2]:13062 "HELO mail.ionium.org")
	by vger.kernel.org with SMTP id <S315415AbSIHVw6> convert rfc822-to-8bit;
	Sun, 8 Sep 2002 17:52:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
Date: Sun, 8 Sep 2002 23:57:26 +0200
User-Agent: KMail/1.4.2
References: <200209030153.47433.jh@ionium.org> <1031139394.3017.61.camel@irongate.swansea.linux.org.uk> <200209042135.17630.jh@ionium.org>
In-Reply-To: <200209042135.17630.jh@ionium.org>
Cc: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209082357.27413.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 September 2002 21:35, Justin Heesemann wrote:
> On Wednesday 04 September 2002 13:36, Alan Cox wrote:
> > I don't know. Without a serial console oops dump I don't have time to
> > figure it out either

seems like serial console doesn't dump anything in my case.

>
> when i used the boot option:
> mem=exactmap mem=640K@0 mem=510M@1M
> i was able to boot the kernel.
>
> however.. when i tried to boot from a 2.4.19 kernel boot cd, it failed
> with:
>
> here is the dmesg:
>
> Linux version 2.4.20-pre5-ac1 (root@lux) (gcc version 2.95.3 20010315
> (release)) #1 Sun Sep 1 17:26:49 Local time zone must be set--see zic manua
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000a0000 - 000000001fef0000 (reserved)
>  BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
>  BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
> user-defined physical RAM map:
>  user: 0000000000000000 - 00000000000a0000 (usable)
>  user: 0000000000100000 - 000000001ff00000 (usable)
> 511MB LOWMEM available.

i tried again with a 2.2 kernel. they don't seem to require _any_ mem=xxx 
parameters to work so i checked dmesg:

Linux version 2.2.20-idepci (herbert@gondolin) (gcc version 2.7.2.3) #1 Sat 
Apr 20 12:45:19 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usuable)
 BIOS-e820: 1fdf0000 @ 00100000 (usuable)
Detected 2019977 kHz processor.


This is the same computer, same RAM, same Bios.
how comes e820 provides these different results ?

--
Best Regards
Justin

