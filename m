Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTFKCTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTFKCTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:19:20 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:16650 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264009AbTFKCTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:19:19 -0400
Date: Tue, 10 Jun 2003 19:32:43 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030610193243.A18623@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030603165438.A24791@google.com> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <20030610182824.A18280@google.com> <20030611014717.GB6754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611014717.GB6754@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Jun 11, 2003 at 02:47:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 02:47:17AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Now, _that_ is interesting.  What are you actually seeing there?
> Note that unhashing doesn't change _any_ ->d_count - hash chains
> are not counted in it and ->d_parent is not changed.

ahh, ok, thanks.  (Thanks also to Trond for nudging me in the correct
direction!)  I will look into that some more, then.

But anyway you do agree that the one line fix is correct?  You may have
gotten thrown off track because of my somewhat broken description.

/fc
