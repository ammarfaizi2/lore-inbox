Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132565AbRDKMg2>; Wed, 11 Apr 2001 08:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132567AbRDKMgT>; Wed, 11 Apr 2001 08:36:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14604 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132565AbRDKMgK>; Wed, 11 Apr 2001 08:36:10 -0400
Subject: Re: [PATCH] i386 rw_semaphores fix
To: ak@suse.de (Andi Kleen)
Date: Wed, 11 Apr 2001 13:36:48 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), ak@suse.de (Andi Kleen),
        tao@acc.umu.se (David Weinehall), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dhowells@cambridge.redhat.com (David Howells),
        andrewm@uow.edu.au (Andrew Morton), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010411032354.A29422@gruyere.muc.suse.de> from "Andi Kleen" at Apr 11, 2001 03:23:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nJre-0006Y0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's currently done this way, ld-linux.so looks in a special "686" path when
> the ELF vector mentions it, otherwise normal path. There is a special 686
> version of glibc and linuxthread. Just it's a very complicated and disk 
> space chewing solution for a simple problem (some distributions are starting 
> to drop support for 386 because of that)

So drop your support for that distribution. I do not see the problem here. Look
at PS/2 support as another example. Supporting the IBM PS/2 machines is
commercially impractical and has no business case. Red Hat won't install on
a PS/2 machine. Debian has different constraints and guess what - Debian 
installs beautifully on a PS/2.

Alan

