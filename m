Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSI2RC0>; Sun, 29 Sep 2002 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbSI2RCZ>; Sun, 29 Sep 2002 13:02:25 -0400
Received: from mail.scram.de ([195.226.127.117]:42441 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261268AbSI2RCW>;
	Sun, 29 Sep 2002 13:02:22 -0400
Date: Sun, 29 Sep 2002 19:06:06 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: Gerhard Mack <gmack@innerfire.net>
cc: james <jdickens@ameritech.net>, Linus Torvalds <torvalds@transmeta.com>,
       Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <Pine.LNX.4.44.0209290858170.22404-100000@innerfire.net>
Message-ID: <Pine.LNX.4.44.0209291900080.18326-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerhard,

> Some of us are waiting until it actually compiles for us ;) (see previous
> bug report)

Ack (on Alpha), and waiting that after compiling, it also boots :-)

My Avanti (currently running 2.5.18):

cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV4
cpu variation           : 0
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : Avanti
system variation        : 0
system revision         : 0
system serial number    : MILO-2.2-18
cycle frequency [Hz]    : 166521620
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 34
max. addr. space #      : 63
BogoMIPS                : 326.08
kernel unaligned acc    : 7671003
(pc=fffffc0000954730,va=fffffc00052da056)
user unaligned acc      : 252 (pc=120011758,va=12006c7e4)
platform string         : N/A
cpus detected           : 0

with

CONFIG_FB_ATY=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_CT=y

i just get a black screen with a wild jumping cursor and than a hang. With
"normal" console, the boot dies with an zero-pointer exception.

I'll try to compile 2.5.39 and send more details about the compile
failures and boot exceptions...

--jochen

