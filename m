Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275061AbRJJVMw>; Wed, 10 Oct 2001 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276075AbRJJVMm>; Wed, 10 Oct 2001 17:12:42 -0400
Received: from citd-ppp.paderlinx.de ([193.189.252.149]:6675 "EHLO
	mail.citd.de") by vger.kernel.org with ESMTP id <S275061AbRJJVM3>;
	Wed, 10 Oct 2001 17:12:29 -0400
Date: Wed, 10 Oct 2001 23:12:58 +0200 (MEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: VM-Problems in 2.4.11
Message-ID: <Pine.LNX.4.20.0110102302170.15834-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>



I have a system with 3GB RAM and no Swap at all.

Before the test "free" showed about 2GB for "cached" and about 800MB was
free. ("Fresh"-System after boot up. Only copied some files before)

Then i wanted to copy about 1.5GB to a "tmpfs" mount.

After about 800MB the copying stopped. On another console, where i wanted
to run "free" again, i just got a "out of memory"-type of warning.
(No errors showed up in syslog)

I had to abort the copy and umount the tmpfs-partition.


With 2.4.9 this scenario works without problems.


If any more informations is needed, i will provide them.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


