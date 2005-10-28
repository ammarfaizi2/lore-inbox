Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVJ1TsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVJ1TsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVJ1TsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:48:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030311AbVJ1TsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:48:03 -0400
Date: Fri, 28 Oct 2005 12:47:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       david-b@pacbell.net
Subject: Re: [PATCH] pci device wakeup flags
In-Reply-To: <20051028123434.09c5cb2f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0510281247010.4664@g5.osdl.org>
References: <11304810221338@kroah.com> <11304810223093@kroah.com>
 <20051028035116.112ba2ca.akpm@osdl.org> <20051028155044.GA11924@kroah.com>
 <20051028123434.09c5cb2f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Oct 2005, Andrew Morton wrote:

> Greg KH <greg@kroah.com> wrote:
> >
> > I
> >  thought that it was one of the usb patches in my tree that was causing
> >  you problems.
> 
> That's a separate problem.  gregkh-usb-usb-pm-09.patch causes my x86 box to
> hang partway though boot.  I drop that from -mm as well.

Just to verify: that one isn't in the current driver core tree, right? I 
assume that's in Greg's USB tree..

Greg?

		Linus
