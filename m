Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbRERHyQ>; Fri, 18 May 2001 03:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262270AbRERHx5>; Fri, 18 May 2001 03:53:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55306 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262269AbRERHxr>; Fri, 18 May 2001 03:53:47 -0400
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
To: alborchers@steinerpoint.com
Date: Fri, 18 May 2001 08:50:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        macro@ds2.pg.gda.pl, tytso@mit.edu, pberger@brimson.com (Peter Berger)
In-Reply-To: <3B048518.705AC5F3@steinerpoint.com> from "Al Borchers" at May 17, 2001 09:12:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150f2E-0006oP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:
> > It has to be changed, the race is basically unfixable any other way. I didn't
> > lightly make that change
> 
> I agree.  The patch seems like the correct solution.  What will it take to
> get the patch in the 2.4.x kernels?  Do we need someone to go through the serial
> drivers and fix their open/close routines to work with this patch?  Peter
> and I can take some time to do that--if that would help.

That would be one big help. Having done that I'd like to go over it all with
Ted first (if he has time) before I push it to Linus

