Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbREOVAT>; Tue, 15 May 2001 17:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261516AbREOVAM>; Tue, 15 May 2001 17:00:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17924 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261522AbREOU7q>; Tue, 15 May 2001 16:59:46 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 21:55:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0105150815570.1802-100000@penguin.transmeta.com> from "Linus Torvalds" at May 15, 2001 08:16:31 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zlqn-00032A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 15 May 2001, Alan Cox wrote:
> > Counter argument; We dont want the bloat of making a floppy tape have
> > delusions of grandeur in kernel space when mt-st can do it in userspace.
> 
> Counter-counter-argument: we could just export the ioctl's, and make a
> "user-level-filesystem". Except it's not a filesystem, but a driver.

Still pushes code into kernel space. Im all for 'tapes' as one set of objects
and a cleaner user space fallback than peer at the major
