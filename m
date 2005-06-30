Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVF3Tcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVF3Tcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVF3Tbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:31:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:16526 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262986AbVF3TaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:30:01 -0400
Date: Thu, 30 Jun 2005 08:54:53 -0700
From: Greg KH <greg@kroah.com>
To: eric.valette@free.fr
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty /dev
Message-ID: <20050630155453.GA6828@kroah.com>
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120137161.42c3efc93b36c@imp1-q.free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 03:12:41PM +0200, eric.valette@free.fr wrote:
> Quoting Greg KH <greg@kroah.com>:
> 
> > On Wed, Jun 29, 2005 at 11:03:56PM +0200, Eric Valette wrote:
> > > For years now my /dev has been empty. When upgrading to 2.6.13-rc1 from
> > > 2.6.12, and updating my kernel config file via "make oldconfig" I got no
> > > visible warning about CONFIG_DEVFS_FS options being set (or at least did
> > > no see it).
> >
> > devfs has been marked OBSOLETE for a year now.  It has also been
> > documented as going away.  Because of this, you should not have been
> > supprised at all.
> 
> I knew it! I just the announce for 2.6.13-rc1 did not contain this fact and I
> did not realize booting this new kernel will fail on my machine which is bad for
> a stable serie.

As there is no longer a "development series" calling 2.6 a "stable
series" isn't really true :)

thanks,

greg k-h
