Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314182AbSDMBoZ>; Fri, 12 Apr 2002 21:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314183AbSDMBoY>; Fri, 12 Apr 2002 21:44:24 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:48650 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314182AbSDMBoY>;
	Fri, 12 Apr 2002 21:44:24 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Roach, Mark R." <mrroach@uhg.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ES1878 doesn't work in 2.4 series kernel 
In-Reply-To: Your message of "12 Apr 2002 09:13:40 EST."
             <1018620823.24746.23.camel@tncorpmrr001.uhg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Apr 2002 11:44:12 +1000
Message-ID: <22564.1018662252@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Apr 2002 09:13:40 -0500, 
"Roach, Mark R." <mrroach@uhg.net> wrote:
>I have a compaq armada 1592DMT and have been unable to get the sound
>card to work under 2.4.17 or 2.4.18 kernels (debian stock kernels or
>compiled from source). 

On my 1598DT I use sb instead of es1878 and it works.

.config
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m

/etc/modules.conf
options sb io=0x220 irq=5 dma=1 dma16=5 mpu_io=0x300

syslog.

Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: No ISAPnP cards found, trying standard ones...
SB 3.01 detected OK (220)
ESS chip ES1878 detected

Let the music begin!

