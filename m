Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQKBEpG>; Wed, 1 Nov 2000 23:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129726AbQKBEo4>; Wed, 1 Nov 2000 23:44:56 -0500
Received: from kootenai.mcn.net ([204.212.170.6]:16138 "EHLO kootenai.mcn.net")
	by vger.kernel.org with ESMTP id <S130021AbQKBEom>;
	Wed, 1 Nov 2000 23:44:42 -0500
Message-ID: <3A00F17B.1E7537FA@mcn.net>
Date: Wed, 01 Nov 2000 21:45:47 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-via@gtf.org
Subject: Re: Announce: Via audio driver update
In-Reply-To: <39E54117.37461BD1@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> An update of the Via audio driver for Linux 2.4.x kernels has been
> posted at
> 
>         http://gtf.org/garzik/drivers/via82cxxx/
>

Hi Jeff,

Somewhere between v1.1.8 and 1.1.10 (I haven't tried 1.1.9), the output
quality has degraded noticeably.  The first thing I noticed was a 
horrendous squeal when starting X: ESD/Enlightenment w/sound enabled
theme.  Possible feedback? May have to try with the mic unplugged.  Any-
way, this theme uses audible clicks when moving between windows.  With
versions .10 .12 .14; instead of click click click..., I get more of a
click kheh heh heh heck click......  If I have pcm music playing all the
time, the themed audio events all seem to work correctly.  Acts like
it's
not playing the buffers completely through otherwise.  Also, playing
music with these versions indicates a tad more background noise, kinda
like tape hiss.  Haven't had the time to see what changed in the source.

GCC:	2.95.2
binutils:	2.9.5.0.46
MB:	Aopen AK72 w/Athlon 750
Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 2).
PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (rev 0).
ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
34).
IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 32).

Thanks for the driver, by the way.
===============
-- TimO
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
