Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135677AbRDXPAt>; Tue, 24 Apr 2001 11:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135676AbRDXPAk>; Tue, 24 Apr 2001 11:00:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41484 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135672AbRDXPAY>; Tue, 24 Apr 2001 11:00:24 -0400
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
To: cat@zip.com.au (CaT)
Date: Tue, 24 Apr 2001 15:59:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        mhaque@haque.net (Mohammad A. Haque),
        ttel5535@artax.karlin.mff.cuni.cz,
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010425004710.F1245@zip.com.au> from "CaT" at Apr 25, 2001 12:47:10 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s4Hq-0002F0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	Copying spool articles matching the peercred to the client does not
> 
> Running procmail as the user who is to receive the email for local mail
> delivery as running it with gid mail (for eg) would allow one user to
> modify another's mail.

What is this gid mail crap ? You don't need priviledge. You get the mail by
asking the daemon for it. procmail needs no priviledge either if it is done
right.

You just need to think about the security models in the right way. Linux gives
you the ability to do authenticated uid/gid checking over a socket connection.
That is an incredibly powerful model for real compartmentalisation.

Alan

