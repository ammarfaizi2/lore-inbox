Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270339AbRIBX26>; Sun, 2 Sep 2001 19:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270401AbRIBX2i>; Sun, 2 Sep 2001 19:28:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63500 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270339AbRIBX2g>; Sun, 2 Sep 2001 19:28:36 -0400
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on parisc architecture
To: willy@debian.org (Matthew Wilcox)
Date: Mon, 3 Sep 2001 00:31:10 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), willy@debian.org, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at Sep 03, 2001 12:25:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dghq-0000bZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it impossible to handle unaligned access traps properly on
> > parisc?  If so, well you have some problems...
> 
> No, we just haven't bothered to implement it yet.  Not many people
> use IPX these days.

You also need unaligned trap fixups for

AX.25, NetROM, LAPB, X.25, Appletalk, PPP, Anything over 802.2LLC, Linus
NFS code for some NFS mount options (although not the -ac NFS code)

Alan
