Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUEMBbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUEMBbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 21:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUEMBbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 21:31:12 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:38087 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261711AbUEMBbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 21:31:09 -0400
Subject: Re: From Eric Anholt:
From: Eric Anholt <eta@lclark.edu>
To: DRI <dri-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405112334.i4BNYdjO018918@turing-police.cc.vt.edu>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org>
	 <20040511222245.GA25644@kroah.com>
	 <Pine.LNX.4.58.0405120018360.3826@skynet>
	 <200405112334.i4BNYdjO018918@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1084412350.774.75.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 18:39:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 16:34, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 12 May 2004 00:20:51 BST, Dave Airlie said:
> 
> > I just looked at drm.h and nearly all the ioctls use int, this file is
> > included in user-space applications also at the moment, I'm worried
> > changing all ints to __u32 will break some of these, anyone on DRI list
> > care to comment?
> 
> Is this a case where somebody is *really* including kernel headers in userspace
> and we need to smack them, or are they using a copy that's been sanitized
> (and possibly fixed)?

These headers being discussed are what define the interface between
userland and kernel, and nothing else.  They are included by both
userland (libdrm, statically linked in the 3d drivers and in the X
server) and kernel.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


