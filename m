Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbUAPPqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUAPPqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:46:53 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:51980 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265527AbUAPPqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:46:52 -0500
Date: Fri, 16 Jan 2004 16:46:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: GOTO Masanori <gotom@debian.or.jp>, arjanv@redhat.com,
       Steve Youngs <sryoungs@bigpond.net.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
Message-ID: <20040116164639.A2809@pclin040.win.tue.nl>
References: <E1AeMqJ-00022k-00@minerva.hungry.com> <2flllofnvp6.fsf@saruman.uio.no> <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org> <1073814570.4431.3.camel@laptop.fenrus.com> <817jzsd8lg.wl@omega.webmasters.gr.jp> <20040116012511.GI21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040116012511.GI21151@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Fri, Jan 16, 2004 at 01:25:11AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 01:25:11AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:

> > and so on.  It can easily exceed 6 symlinks.  I think the correct fix
> > is to make VFS not to overflow stacks.  Is it allowable change?
> 
> 	You are quite welcome to submit clean patches that would do that.
> So far all suggested "solutions" had turned out to be broken _and_ ugly.

Ugly, possibly - broken, no.

