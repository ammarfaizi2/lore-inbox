Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSBZU6G>; Tue, 26 Feb 2002 15:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293542AbSBZU54>; Tue, 26 Feb 2002 15:57:56 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:39665 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292555AbSBZU5n>;
	Tue, 26 Feb 2002 15:57:43 -0500
Date: Tue, 26 Feb 2002 13:57:16 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
Message-ID: <20020226135716.S12832@lynx.adilger.int>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226113402.K12832@lynx.adilger.int> <Pine.GSO.4.21.0202262117380.8085-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0202262117380.8085-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Feb 26, 2002 at 09:19:46PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  21:19 +0100, Geert Uytterhoeven wrote:
> So in case he wants a few csets only, I have to redo my for-Him-to-pull-tree.
> In which case I don't see any advantages compared to emailing a patch with
> changeset- and file-specific comments. Especially since setting up a
> for-Him-to-pull-tree requires setting up a publically accessible BK server.

If you want to just send occasional CSETs to Linus or Dave Jones (which
is the category that a large majority of people are in) then you can
always send a CSET in the mail instead of having a "pull" tree available.
Search the l-k archives for my "bksend" script which formats this nicely.

One of the benefits of using BK over patches, even in this situation, is
that if your tree is not exactly the same as Linus' the BK CSET will know
what version of the tree it was generated against and will make applying
and resolving conflicts a lot easier for Linus.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

