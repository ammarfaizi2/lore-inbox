Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132185AbRCVVDS>; Thu, 22 Mar 2001 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132009AbRCVVDI>; Thu, 22 Mar 2001 16:03:08 -0500
Received: from chemix.ch.pw.edu.pl ([194.29.156.1]:20499 "EHLO
	chemix.ch.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S131891AbRCVVC5>; Thu, 22 Mar 2001 16:02:57 -0500
Date: Thu, 22 Mar 2001 22:17:11 +0100 (CET)
From: Jacek Lipkowski <sq5bpf@acid.ch.pw.edu.pl>
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec/DPT RAID Drivers [Was: Re: DPT Driver Status]
In-Reply-To: <5.0.2.1.2.20010316021553.01c71480@172.17.0.107>
Message-ID: <Pine.LNX.4.21.0103222206430.9748-100000@acid.ch.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Omar Kilani wrote:

> Kernel 2.4.2
> http://aurore.net/source/dpt_i2o-2.0-2.4.2.gz

i also have a patched linux-2.4.2-ac20 tree for my own use at
ftp://acid.ch.pw.edu.pl/pub/sq5bpf/linux-2.4.2-ac20+dpt.tar.gz  that
supports dpt smartraid V (i found a patch for 2.4.0-pre6 and hand patched
it in). it seems to work with my ISP2150 (didn't crash yet :), after
compiling with egcs 1.1.2 (some people warned about using anything else
than gcc 2.7.2.3).

the only caveat is that if you set the ramsize 49152, root flags to 0 etc
so it loads a floppy after a prompt, the dpt controller (and eepro100
that was also compiled in) gets initialised _after_ the root floppy is
loaded. i'm not sure if this is a bug with the dpt patch or with the
original kernel (will  check tomorrow).

jacek


