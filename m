Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136290AbRECJ12>; Thu, 3 May 2001 05:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136291AbRECJ1S>; Thu, 3 May 2001 05:27:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46341 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136290AbRECJ1E>; Thu, 3 May 2001 05:27:04 -0400
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
To: volodya@mindspring.com
Date: Thu, 3 May 2001 10:29:43 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro), andrea@suse.de (Andrea Arcangeli),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0105030221050.5590-100000@node2.localnet.net> from "volodya@mindspring.com" at May 03, 2001 02:23:35 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vFQf-0005Ej-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > discussion in itself), and there really are no valid uses for opening a
> > block device that is already mounted. More importantly, I don't think
> > anybody actually does.
> 
> Actually I did. I might do it again :) The point was to get the kernel to
> cache certain blocks in the RAM. 

Ditto for some CD based stuff. You burn the important binaries to the front
of the CD, then at boot dd 64Mb to /dev/null to prime the libraries and
avoid a lot of seeking during boot up from the CD-ROM.

However I could do that from an initrd before mounting

Alan

