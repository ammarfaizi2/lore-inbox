Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUDUIpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUDUIpQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 04:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUDUIpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 04:45:16 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:2744 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S264286AbUDUIpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 04:45:09 -0400
From: Axel =?iso-8859-2?q?Wei=DF?= <aweiss@informatik.hu-berlin.de>
Organization: =?iso-8859-15?q?Humboldt-Universit=E4t=20zu?= Berlin
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: build system broken in 2.6.6rc1 for external modules?
Date: Wed, 21 Apr 2004 10:45:03 +0200
User-Agent: KMail/1.5.1
References: <200404191956.53184.arekm@pld-linux.org> <20040419205817.GA2090@mars.ravnborg.org> <200404192307.31059.arekm@pld-linux.org>
In-Reply-To: <200404192307.31059.arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404211045.03547.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 19. April 2004 23:07 schrieb Arkadiusz Miskiewicz:
> Dnia Monday 19 of April 2004 22:58, Sam Ravnborg napisa³:
> > There is currently a glitch that requires you to have defined
> > at least one module in the kernel. net/dummy for example.
> > When next round of patched are in you will not need to build the full
> > kernel either.
>
> Great but with 2.6.5 kernel (2.6.4, too. previous probably too) I was able
> to build modules without need to build the full kernel.
>
> > If you do not want (cannot) build the kernel in the $KERNELSRCDIR
> > then you can use:
> >
> > cd $KERNELSRCDIR
> > copy config-up ~/build
> > make O=~/build
>
> This will start building kernel for me! I don't want that. I want only few
> external modules to be built.

If you are interested, I will send you a brief Makefile for compiling external 
modules. It works on a clean kernel source tree without compiling the whole 
kernel.

Regards,
Axel
-- 
Humboldt-Universität zu Berlin
Institut für Informatik
Signalverarbeitung und Mustererkennung
Dipl.-Inf. Axel Weiß
Rudower Chaussee 25
12489 Berlin-Adlershof
+49-30-2093-3050

