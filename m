Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287376AbRL3KGf>; Sun, 30 Dec 2001 05:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287370AbRL3KGZ>; Sun, 30 Dec 2001 05:06:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44294 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287372AbRL3KGP>; Sun, 30 Dec 2001 05:06:15 -0500
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 30 Dec 2001 10:15:12 +0000 (GMT)
Cc: akpm@zip.com.au (Andrew Morton), andrea@suse.de (Andrea Arcangeli),
        torvalds@transmeta.com (Linus Torvalds), torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br (Marcelo Tosatti),
        sct@redhat.com (Stephen C. Tweedie)
In-Reply-To: <Pine.GSO.4.21.0112300153520.8523-100000@weyl.math.psu.edu> from "Alexander Viro" at Dec 30, 2001 02:17:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Kczo-0000iw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, the fs consistency stuff is a different story.  Fixes had been
> in -ac since before 2.4.0 and I distinctly remember at least one of
> 3 area getting synced with -linus.  My fault - I assumed that the
> whole patch went there at that point.  I'll try to dig the rest out.

I didnt feed Marcelo the final truncate stuff nor the file write fixes, it
was getting too close to 2.4.17 and they are not completely risk free
sort of changes.

