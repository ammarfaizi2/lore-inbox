Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBUQ7s>; Wed, 21 Feb 2001 11:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129396AbRBUQ7j>; Wed, 21 Feb 2001 11:59:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13162 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129184AbRBUQ7Z>; Wed, 21 Feb 2001 11:59:25 -0500
Date: Wed, 21 Feb 2001 18:00:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux LVM Development list <lvm-devel@sistina.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Heinz Mauelshagen <mauelshagen@sistina.com>
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
Message-ID: <20010221180035.N25927@athlon.random>
In-Reply-To: <20010220234219.B2023@athlon.random> <200102210031.f1L0VQU15564@webber.adilger.net> <20010221021252.A932@athlon.random> <200102210349.f1L3nHE03110@mobilix.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102210349.f1L3nHE03110@mobilix.atnf.CSIRO.AU>; from rgooch@ras.ucalgary.ca on Wed, Feb 21, 2001 at 02:49:17PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 02:49:17PM +1100, Richard Gooch wrote:
> You definately can mknod(2) on devfs. [..]

So then why don't we simply create the VG ourself with the right minor number
and use it as we do without devfs? We'll still have a global 256 VG limit this
way but that's not a minor issue.

Andrea
