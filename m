Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282390AbRKXHjt>; Sat, 24 Nov 2001 02:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282393AbRKXHjj>; Sat, 24 Nov 2001 02:39:39 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:22402 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S282389AbRKXHjd>;
	Sat, 24 Nov 2001 02:39:33 -0500
Date: Fri, 23 Nov 2001 13:46:40 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Dike <jdike@karaya.com>
Cc: Adam Feuer <adamf@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Swsusp mailing list <swsusp@lister.fornax.hu>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Gabor Kuti <seasons@falcon.sch.bme.hu>
Subject: Re: [swsusp] Re: swsusp for 2.4.14
Message-ID: <20011123134639.A55@toy.ucw.cz>
In-Reply-To: <20011121164620.D31379@atrey.karlin.mff.cuni.cz> <200111211853.NAA03050@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200111211853.NAA03050@ccure.karaya.com>; from jdike@karaya.com on Wed, Nov 21, 2001 at 01:53:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yep, I'd like to see it. [The way uml is setup with one uml kernel
> > running in *many* real processes, saving/restoring cpu state is not
> > going to be easy.]
> 
> It won't be horrible.  You have to recreate all the processes (and getting
> their address spaces mapped correctly should be easy) and get them all
> ptraced by the tracing thread.  UML processes which are CLONE_VM are also
> CLONE_VM on the host, so that will take a little bit of care.

Yep, its doable, but way harder than other ports where you only have to restore
CPU registers. And yes it would be cool.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

