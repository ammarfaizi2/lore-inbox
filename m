Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFCNaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFCNaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVFCNaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:30:07 -0400
Received: from thunk.org ([69.25.196.29]:56732 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261254AbVFCNaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:30:03 -0400
Date: Fri, 3 Jun 2005 09:29:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Gerd Knorr <kraxel@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050603132924.GA25643@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Gerd Knorr <kraxel@suse.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, toon@hout.vanvergehaald.nl, ltd@cisco.com,
	linux-kernel@vger.kernel.org, dtor_core@ameritech.net,
	7eggert@gmx.de
References: <20050531190556.GK23621@csclub.uwaterloo.ca> <200506010223.j512NgeC005179@laptop11.inf.utfsm.cl> <20050601155629.GK23488@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601155629.GK23488@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:56:29AM -0400, Lennart Sorensen wrote:
> > Why? Just use LABELs, ou UUIDs.
> 
> Great if those worked on ALL filesystems, which to my knowledge they do
> not.  Last time I tried to use labels to mount filesystems, I gave up on
> it when I discovered swap didn't support it.  I haven't bothered with
> them since.

While filesystems do you need?  Most filesystems actually do have
LABELs or UUID's, including FAT, VFAT, iso9660, ext2/3, reiserfs, xfs,
etc.  OK, xiafs doesn't have labels or uuid's, but it was removed from
the Linux tree before 2.4 shipped!

						- Ted
