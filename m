Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRDGT5C>; Sat, 7 Apr 2001 15:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRDGT4x>; Sat, 7 Apr 2001 15:56:53 -0400
Received: from ns.suse.de ([213.95.15.193]:24331 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131219AbRDGT4m>;
	Sat, 7 Apr 2001 15:56:42 -0400
Date: Sat, 7 Apr 2001 21:56:40 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: <linux-kernel@vger.kernel.org>, <bert@dutepp0.et.tudelft.nl>,
        <jeanpaul@dutepp0.et.tudelft.nl>
Subject: Re: P-III Oddity. 
In-Reply-To: <200104071933.VAA19651@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.30.0104072149510.10936-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Apr 2001, Rogier Wolff wrote:

> One machine regularly crashes.
> Linux version 2.2.16-3 (root@porky.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Jun 19 19:11:44 EDT 2000

Probably unrelated to the issue below. Try a more recent 2.2 ?

> cpuid level     : 2

CPU serial number disabled.

> cpuid level     : 3

CPU serial number enabled.


You should be able to confirm this with my x86info tool.
ftp://ftp.suse.com/pub/people/davej/x86info/x86info-1.0.tgz

If this isn't the case, can you send me the output of
x86info -a on both CPUs ?

Note, that 2.4 should be disabling the serial number by
default.
(Unless you booted with the `serialnumber' bootarg.)

regards,

Dave.

