Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267416AbTALTXe>; Sun, 12 Jan 2003 14:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTALTXe>; Sun, 12 Jan 2003 14:23:34 -0500
Received: from suonpaa.iki.fi ([62.236.96.196]:11210 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S267414AbTALTWq>; Sun, 12 Jan 2003 14:22:46 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: robw@optonline.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel And Kenrel Programming
References: <Pine.LNX.4.44.0301112346450.2270-100000@bailey.scraps.org>
	<1042382565.848.11.camel@RobsPC.RobertWilkens.com>
	<1042389923.15051.1.camel@irongate.swansea.linux.org.uk>
	<1042390735.1208.5.camel@RobsPC.RobertWilkens.com>
	<1042394046.15051.21.camel@irongate.swansea.linux.org.uk>
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: Sun, 12 Jan 2003 21:30:27 +0200
In-Reply-To: <1042394046.15051.21.camel@irongate.swansea.linux.org.uk> (Alan
 Cox's message of "12 Jan 2003 17:54:07 +0000")
Message-ID: <87y95qjhd8.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> For example the O(1) scheduler will trigger very occasional random
> crashes or reboots with early PII Xeon microcode sets. I'm sure
> Debian has a package for this somewhere.

Something like this, I guess:

$ apt-cache show microcode.ctl
Package: microcode.ctl
[...]
Description: Intel IA32 CPU Microcode Utility
 The microcode_ctl utility is a companion to the IA32 microcode driver
 written by Tigran Aivazian <tigran@veritas.com>. The utility has two
 uses:
 .
 a) it decodes and sends new microcode to the kernel driver to be
    uploaded to Intel IA32 family processors. (Pentium Pro, PII,
    Celeron, PIII, Xeon, Pentium 4 etc.)
 b) it signals the kernel driver to release any buffers it may hold
 .
 The microcode update is volatile and needs to be uploaded on each
 system boot i.e. it doesn't re-flash your CPU permanently, reboot and
 it reverts back to the old microcode. The ideal place to load
 microcode is in BIOS, but most vendors never update it!
 .
 To enable microcode update, I need some kernel support, thus I need
 the linux kernel 2.2.18 or later, or 2.4.0 or later.

Suonp‰‰...
