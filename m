Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbUATIc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUATIcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:32:24 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:528 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265254AbUATIcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:32:14 -0500
Date: Tue, 20 Jan 2004 00:30:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
In-Reply-To: <Pine.LNX.4.58.0401192259330.2123@home.osdl.org>
Message-ID: <Pine.LNX.4.10.10401200028460.21664-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Would have been nice to list such rules at the top if the MAINTAINERS
file, this may have saved me some grief, well maybe not ...

Andre Hedrick
LAD Storage Consulting Group

On Mon, 19 Jan 2004, Linus Torvalds wrote:

> 
> 
> On Mon, 19 Jan 2004, Justin T. Gibbs wrote:
> > 
> > Does the maintainer have the ability to veto changes that harm the
> > code they maintain?
> 
> Nope. Nobody has that right.
> 
> Even _I_ don't veto changes that the right people push (my motto:
> "everybody is wrong sometimes: when enough people complain, even I am
> wrong"). 
> 
> In particular, maintainers of "conceptually higher" generally always have
> priority. If Al Viro says a filesystem is doing something wrong from a VFS
> standpoint, then that filesystem is broken - regardless of whether the
> filesystem maintainer agrees or not. Because the VFS layer requirements 
> trump any low-level filesystem issues.
> 
> But perhaps more importantly (and it's the reason even _I_ don't have the 
> right, regardless of how high up in the maintainership chain I am), nobody 
> has veto-power over anything. That's to keep people honest: nobody should 
> _ever_ think that they are "in control", and that nobody else can replace 
> them. 
> 
> In other words: maintainership is not ownership. It's a stewardship.
> 
> End result: maintainership is a nasty and mostly unthankful job. It
> doesn't really give many privileges, and most of what it does is just have
> people complain to you about bugs. The satisfaction is there, of course, 
> but 
> 
> And finally: maintainership is largely about working with people.  
> There's some code in there too, but people tend to be more important.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

