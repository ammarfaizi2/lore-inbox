Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSGIPam>; Tue, 9 Jul 2002 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSGIPal>; Tue, 9 Jul 2002 11:30:41 -0400
Received: from c-24-118-234-119.mn.client2.attbi.com ([24.118.234.119]:48001
	"EHLO c-24-118-234-119mnclient2attbicom") by vger.kernel.org
	with ESMTP id <S315458AbSGIPal>; Tue, 9 Jul 2002 11:30:41 -0400
Date: Tue, 9 Jul 2002 10:29:59 -0500 (CDT)
From: "Scott M. Hoffman" <scott783@attbi.com>
X-X-Sender: scott@ScottnBonnies.attbi.com
Reply-To: scott783@attbi.com
To: Duncan Sands <duncan.sands@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.25-dj1
In-Reply-To: <200207091140.42367.duncan.sands@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0207091026270.14288-100000@ScottnBonnies.attbi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002 at 11:40 +0200 Duncan Sands wrote:

> fs/fs.o: In function `proc_pid_stat':
> fs/fs.o(.text+0x1fb72): undefined reference to `__udivdi3'
> fs/fs.o: In function `kstat_read_proc':
> fs/fs.o(.text+0x20b42): undefined reference to `__udivdi3'
> fs/fs.o(.text+0x20bd0): undefined reference to `__udivdi3'
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.5.25-dj1'
> make: *** [stamp-build] Error 2
> 


I'm also getting this error.  Looking it up on Google points to earlier 
problems than 2.5.25, both with binutils and gcc.  I've tried binutils 
2.11, 2.12 and gcc 2.95.3, 2.96(RH 7.3), and 3.1.  No combination seems 
to work.


-- 
Scott M. Hoffman
scott783@attbi.com
Running Linux 2.4.18-3smp, up 0 days 17 hours 7 minutes

