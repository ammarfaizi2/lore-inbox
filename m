Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271677AbRICLEF>; Mon, 3 Sep 2001 07:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271679AbRICLDz>; Mon, 3 Sep 2001 07:03:55 -0400
Received: from lxmayr6.informatik.tu-muenchen.de ([131.159.44.50]:24960 "EHLO
	lxmayr6.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S271677AbRICLDr>; Mon, 3 Sep 2001 07:03:47 -0400
Date: Mon, 3 Sep 2001 13:04:04 +0200
From: Ingo Rohloff <rohloff@in.tum.de>
To: epic@scyld.com, linux-kernel@vger.kernel.org
Subject: epic100.c, SMC EtherPower II, SMC83c170/175 "EPIC"
Message-ID: <20010903130404.B1064@lxmayr6.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have got a "[SMC] 83C170QF" adaptor in my computer and I wasn't
able to use the driver which is in linux-2.4.9.

The sympotms are lot's of messages of this in /var/log/messages:
"kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004"

This seems to be a known problem; at least I found other people
complaining about the same message in their kernel logs.
The problem has different severity for different people. 
I wasn't able to get the card working at all (basically the
computer hung, while trying to mount several NFS directories).

After searching the web for further information I was able
to obtain a patched version, which was modified Heiko Boch. 
It seems this version is an older linux-2.4.x driver with 
some additional patches.

This version works without glitches on my system with a 
vanilla linux-2.4.9 kernel. 

The homepage of Heiko Boch doesn't seem to exist anymore, so
for all people who use this card and have the above problem,
I put his modified version of epic100.c on my home page at
www.in.tum.de/~rohloff (look for epic100.c). 

I hope that after some testing someone can have a look over
this version, who really can tell what the essential differences
compared to the version in linux-2.4.9 are.

Perhaps this will lead to a working linux-2.4.xx version in the future.

so long
  Ingo
