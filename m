Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135651AbRDXOiJ>; Tue, 24 Apr 2001 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRDXOh7>; Tue, 24 Apr 2001 10:37:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28940 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135651AbRDXOhl>; Tue, 24 Apr 2001 10:37:41 -0400
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 24 Apr 2001 15:37:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mhaque@haque.net (Mohammad A. Haque),
        ttel5535@artax.karlin.mff.cuni.cz,
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0104241022040.6992-100000@weyl.math.psu.edu> from "Alexander Viro" at Apr 24, 2001 10:22:52 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s3wf-0002CR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is possible to implement the entire mail system without anything running
> > as root but xinetd.
> 
> You want an MDA with elevated privileges, though...

What role requires priviledge once the port is open ?

	DNS lookup does not
	Spooling to disk does not
	Accepting a connection from a client does not
	Doing peercred auth with a client does not
	Copying spool articles matching the peercred to the client does not

Alan


