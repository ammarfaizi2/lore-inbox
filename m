Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262447AbSKDScB>; Mon, 4 Nov 2002 13:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSKDScB>; Mon, 4 Nov 2002 13:32:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54915 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262447AbSKDScA>; Mon, 4 Nov 2002 13:32:00 -0500
Date: Mon, 4 Nov 2002 13:40:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Thomas Schenk <tschenk@origin.ea.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Need assistance in determining memory usage
In-Reply-To: <1036433472.2884.42.camel@shire>
Message-ID: <Pine.LNX.3.95.1021104133334.12831A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In /proc there are a bunch of directories that are numbered.
These numbers correspond to the PID of each process.
In each of these directories is a file called "status".

This file contains most all the information you need just
in case you don't like `ps` or `top`.

Name:	init
State:	S (sleeping)
Tgid:	1
Pid:	1
PPid:	0
TracerPid:	0
Uid:	0	0	0	0
Gid:	0	0	0	0
FDSize:	32
Groups:	
VmSize:	     224 kB              Total virtual memory accessed so far.
VmLck:	       0 kB              Locks held
VmRSS:	     148 kB              Resident virtual memory (not swapped)
VmData:	      28 kB              Data virtual memory
VmStk:	       4 kB              Stack virtual memory
VmExe:	     184 kB              Executable virtual memory
VmLib:	       0 kB              Shared library
SigPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	0000000057f0defc
SigCgt:	00000000280b2003
CapInh:	0000000000000000
CapPrm:	00000000ffffffff
CapEff:	00000000fffffeff


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


