Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTDGB52 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbTDGB52 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:57:28 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:10741 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263190AbTDGB51 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:57:27 -0400
Date: Sun, 6 Apr 2003 22:04:51 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk12 causes "rpm" errors
In-Reply-To: <20030406183234.1e8abd7f.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0304062200570.1604-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, Andrew Morton wrote:

> "Robert P. J. Day" <rpjday@mindspring.com> wrote:
> >
> > 
> >   got 2.5.66-bk12 to boot on my inspiron 8100, and ran 
> > "rpm -q iptables", got the following:
> > 
> > rpmdb: write: 0xbfffc2d0, 8192: Invalid argument
> > error: db4 error(22) from dbenv->open: Invalid argument
> > error: cannot open Packages index using db3 - Invalid argument (22)
> > error: cannot open Packages database in /var/lib/rpm
> > package iptables is not installed
> > 
> 
> Does it work OK with earlier 2.5 kernels?

sorry, i couldn't tell you about that.

> The only change which comes to mind is the below one.  Could you do a
> patch -R of this and retest?

... patch deleted ...

that fixed it, but i only this second noticed the "-R" for reversing
the patch.  i applied it normally against my 2.5.66-bk12 tree, and
it apparently applied cleanly.  

wouldn't that suggest that that patch wasn't in my tree in the first
place?  i'm sure i'm up to bk12 at this point.

rday

