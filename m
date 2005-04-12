Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVDLVCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVDLVCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVDLUnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:43:32 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:54689 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262167AbVDLTvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:51:33 -0400
Date: Tue, 12 Apr 2005 21:51:15 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>,
       Miklos Szeredi <miklos@szeredi.hu>, dan@debian.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
In-Reply-To: <20050412143707.GD10995@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0504122138280.3024@be1.lrz>
References: <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it>
 <3S9b7-1yl-1@gated-at.bofh.it> <3S9uB-1Lj-3@gated-at.bofh.it>
 <3SbG5-3Mb-41@gated-at.bofh.it> <3ScC1-4zl-1@gated-at.bofh.it>
 <3ScLO-4GA-9@gated-at.bofh.it> <3SdeV-54h-21@gated-at.bofh.it>
 <3SeXf-6BK-21@gated-at.bofh.it> <E1DLKOd-0001Nd-MG@be1.7eggert.dyndns.org>
 <20050412143707.GD10995@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2005, Jamie Lokier wrote:
> Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:

> > > I think that would be _much_ nicer implemented as a mount which is
> > > invisible to other users, rather than one which causes the admin's
> > > scripts to spew error messages.  Is the namespace mechanism at all
> > > suitable for that?
> > 
> > This will require shared subtrees plus a way for new logins from the same
> > user to join an existing (previous login) namespace.
> 
> Or "per-user namespaces".

A general way to enter child namespaces would be much more flexible. The 
mechanism could be reused by projects like linux-vserver.
-- 
Our last fight was my fault: My wife asked me "What's on the TV?"
I said, "Dust!"
