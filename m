Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263782AbREYQBm>; Fri, 25 May 2001 12:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263783AbREYQBc>; Fri, 25 May 2001 12:01:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263782AbREYQBX>; Fri, 25 May 2001 12:01:23 -0400
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
To: nemosoft@smcc.demon.nl (Nemosoft Unv.)
Date: Fri, 25 May 2001 16:58:19 +0100 (BST)
Cc: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw), linux-kernel@vger.kernel.org,
        preining@logic.at (Norbert Preining),
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <XFMail.010525152244.nemosoft@smcc.demon.nl> from "Nemosoft Unv." at May 25, 2001 03:22:44 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153Jyl-0006iS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > that none of the sound drivers does sample rate conversion although
> > some sound chips are locked at 48kHz only.
> 
> True, but a number of audio tools will break, because they don=B4t supp=

So fix the tools

> if you limit the number of available palettes per driver. Plus, you wil=
> l get
> severe fragmentation of which program works with which driver. Which is
> unacceptable, in my opinion (and certainly NOT the idea behind a common=
>  API!)

Fix the tools.

> routines, while (nearly) nothing has been said about other (USB) webcam
> drivers which have conversion routines.

I have those in my firing line too. It has always been the policy that format
conversions go in user space. The kernel is an arbitrator of resources it is
not a shit bucket for solving other peoples incompetence.

Alan

