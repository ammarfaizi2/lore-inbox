Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSGIJoZ>; Tue, 9 Jul 2002 05:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317345AbSGIJoX>; Tue, 9 Jul 2002 05:44:23 -0400
Received: from gw-fxb-in.genebee.msu.ru ([195.208.219.253]:24838 "EHLO
	libro.genebee.msu.su") by vger.kernel.org with ESMTP
	id <S317347AbSGIJoP>; Tue, 9 Jul 2002 05:44:15 -0400
Date: Tue, 9 Jul 2002 13:47:41 +0400 (MSD)
From: Tim Alexeevsky <realtim@mail.ru>
X-X-Sender: <tim@zhuchka>
Reply-To: <realtim@mail.ru>
To: Alex Riesen <Alexander.Riesen@synopsys.com>
cc: Tim Alexeevsky <realtim@mail.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: File accessing.
In-Reply-To: <20020709064825.GA32293@riesen-pc.gr05.synopsys.com>
Message-ID: <Pine.LNX.4.33.0207091326550.390-100000@zhuchka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Today Alex Riesen wrote:

AR>On Sun, Jul 07, 2002 at 02:40:26AM +0400, Tim Alexeevsky wrote:
AR>...
AR>>  Using strace I tracked this problem down to requesting
AR>>  open("jffs2/gc.c", O_READONLY|O_LARGEFILE)
AR>>  Now
AR>>    ls jffs2
AR>>   also gives me a kernel panic. It's on reiserfs.
AR>>
AR>
AR>i'd suggest you start your next day/night with reiserfsck --fix-fixable.
   Sure :)

AR>And you'll have to upgrade your reiserfsprogs up to 3.x.1b.
   Ok.

   But if this is the reason for this subproblem, there are some others
and they all seem to appear simultaneously. They all are the problems with
accessing files. And as long as I got the first problem I will have a
lots of them on different filesystems until I reboot the system (AFAIK).
   Maybe the reason is some damage in global filesystem handling. (Is that
VFS?)

Bye,
Thanx a lot,

                                                         Tim

,-----------------------------------------------------------------------------.
|                      Windows: XT emulator for an AT.                        |
`-----------------------------------------------------------------------------'

