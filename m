Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316255AbSEVRCL>; Wed, 22 May 2002 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316254AbSEVRCK>; Wed, 22 May 2002 13:02:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24068 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316255AbSEVRCJ>; Wed, 22 May 2002 13:02:09 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 22 May 2002 18:22:15 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.44.0205220925120.7580-100000@home.transmeta.com> from "Linus Torvalds" at May 22, 2002 09:28:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AZoV-0002I7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody: if you've ever used /dev/ports, holler _now_.

Holler. I posted a list of examples to linux-kernel already. iopl and ioperm
are not portable in the way /dev/port is. ioperm/iopl also doesnt work
with most scripting languages, java tools trying to avoid JNI etc

I've seen it used in tools written in java, python, perl, even tcl

Other examples include libieee1284, the pic 16x84 programmer, hwclock,
older kbdrate, /sbin/clock on machines that don't have /dev/rtc.

Not everything in the world is an x86, and not every app wants to be Linux/x86
specific or use weird syscalls
