Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbREOWTS>; Tue, 15 May 2001 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbREOWTI>; Tue, 15 May 2001 18:19:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22277 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261643AbREOWS5>; Tue, 15 May 2001 18:18:57 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 15 May 2001 23:14:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at May 15, 2001 03:41:41 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zn4x-0003CZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 	if (strcmp (buffer + len - 2, "cd") != 0) {
> > > 		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
> > > 		exit (1);
> > 
> > And on my box cd is the cabbage dicer whoops
> 
> Actually, no, because it's guaranteed that a trailing "/cd" is a
> CD-ROM. That's the standard.

And its back to /dev/disc versus /dev/disk. Dont muddle user picked file
names with kernel namespace bindings please.


