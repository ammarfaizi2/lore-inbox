Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267983AbRGVOZ0>; Sun, 22 Jul 2001 10:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267982AbRGVOZQ>; Sun, 22 Jul 2001 10:25:16 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:37648 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S267981AbRGVOZD>; Sun, 22 Jul 2001 10:25:03 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: 2.4.[<=6] kernel has Cyrix 'coma' bug?
Date: Sun, 22 Jul 2001 16:23:52 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9jeno4$66r$1@ncc1701.cistron.net>
In-Reply-To: <3B5AD0DF.8DDC5D1E@home.com>
X-Trace: ncc1701.cistron.net 995811908 6363 213.46.44.164 (22 Jul 2001 14:25:08 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Steven Lass" <stevenlass1@home.com> wrote in message
news:cistron.3B5AD0DF.8DDC5D1E@home.com...
>
> dev-list,
>
> Every 2.4 kernel that I've tried freezes my Cyrix MediaGX system at boot
> up.
>

For what it's worth, I use the Slackware 8.0 distribution, and have no
trouble running 2.4.[5-7] on my Cyrix MediaGX 233 MHz. Make sure MTTR is off
in your configuration, this has bit me in the *ss once...

Rob

======
CPU: Before vendor init, caps: 00808131 01818131 00000000, vendor = 1
Working around Cyrix MediaGX virtual DMA bugs.
CPU: After vendor init, caps: 00808121 00818131 00000000 00000001
CPU:     After generic, caps: 00808121 00818131 00000000 00000001
CPU:             Common caps: 00808121 00818131 00000000 00000001
CPU: Cyrix MediaGXtm MMXtm Enhanced stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
=======
robtu@pi8nos:/proc$ cat cpuinfo
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 7
model name      : Cyrix MediaGXtm MMXtm Enhanced
stepping        : 2
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu msr cx8 cmov mmx cxmmx
bogomips        : 76.80





