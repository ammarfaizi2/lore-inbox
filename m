Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSGNUrv>; Sun, 14 Jul 2002 16:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSGNUru>; Sun, 14 Jul 2002 16:47:50 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:23560 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S317115AbSGNUrt>; Sun, 14 Jul 2002 16:47:49 -0400
Date: Sun, 14 Jul 2002 22:50:40 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Heinz Diehl <hd@cavy.de>
cc: Ben Clifford <benc@hawaga.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.25-dj2
In-Reply-To: <20020714111153.GA4692@chiara.cavy.de>
Message-ID: <Pine.LNX.4.33.0207142248250.21196-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Heinz Diehl wrote:

> This leads to:
...
> fs/fs.o: In function proc_pid_stat':
> fs/fs.o(.text+0x21a29): undefined reference to __udivdi3'
> fs/fs.o: In function kstat_read_proc':
> fs/fs.o(.text+0x22a7b): undefined reference to __udivdi3'
> fs/fs.o(.text+0x22b11): undefined reference to __udivdi3'
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory /usr/src/linux'
> make: *** [bzImage] Error 2
> chiara:/usr/src/linux #


known problem, a fix has been posted to the list already
or can be found at
http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-djfix06.patch.gz

Tim

