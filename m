Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274403AbRITK0Y>; Thu, 20 Sep 2001 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274407AbRITK0O>; Thu, 20 Sep 2001 06:26:14 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:9232 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274403AbRITK0B> convert rfc822-to-8bit; Thu, 20 Sep 2001 06:26:01 -0400
X-Envelope-From: mmokrejs
Posted-Date: Thu, 20 Sep 2001 12:26:19 +0200 (MET DST)
Date: Thu, 20 Sep 2001 12:26:18 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: "Magnus Naeslund(f)" <mag@fbab.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile 2.4.10pre12aa1 with 2.95.2 on Debian
In-Reply-To: <05ab01c141bc$6c5a9f60$020a0a0a@totalmef>
Message-ID: <Pine.OSF.4.21.0109201223000.24552-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Magnus Naeslund(f) wrote:

> From: "Martin MOKREJ©" <mmokrejs@natur.cuni.cz>
> 
> There are two defines for that FPU thing around line 421 in sched.c, take
> one away (i deleted the 1<<6 one).

I've just compiled and am going to reboot, one more note:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-pre12/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:1116: Warning: indirect lcall without `*'
{standard input}:1201: Warning: indirect lcall without `*'
{standard input}:1288: Warning: indirect lcall without `*'
{standard input}:1370: Warning: indirect lcall without `*'
{standard input}:1381: Warning: indirect lcall without `*'
{standard input}:1392: Warning: indirect lcall without `*'
{standard input}:1479: Warning: indirect lcall without `*'
{standard input}:1491: Warning: indirect lcall without `*'
{standard input}:1503: Warning: indirect lcall without `*'
{standard input}:1990: Warning: indirect lcall without `*'
{standard input}:2083: Warning: indirect lcall without `*'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-pre12/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o pci-irq.o pci-irq.c

-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany


