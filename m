Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTABQgF>; Thu, 2 Jan 2003 11:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbTABQgF>; Thu, 2 Jan 2003 11:36:05 -0500
Received: from tomts14.bellnexxia.net ([209.226.175.35]:59611 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264877AbTABQgE>; Thu, 2 Jan 2003 11:36:04 -0500
Date: Thu, 2 Jan 2003 11:43:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel .config support?
In-Reply-To: <1041527505.24830.3.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301021141210.8604-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Jan 2003, Alan Cox wrote:

> On Thu, 2003-01-02 at 14:32, Robert P. J. Day wrote:
> > 
> >   whatever happened to that funky option from 2.4 --
> > for kernel .config support, which allegedly buried the
> > config file inside the kernel itself.  (it never worked --
> > the alleged extraction script scripts/extract-ikconfig
> > depended on a program called "binoffset" that didn't 
> > exist in that distribution.)
> 
> Its never been in the standard 2.4 kernel. The facility has been in the
> -ac kernel, and was recently submitted for consideration in 2.5

that's odd.  the selection for kernel .config support has been in
the red hat config menus for at least the last release, as well
as the extraction script .../scripts/extract-ikconfig.  but this
never worked due to a missing "binoffset" utility.  i even filed
a bugzilla on that (bug 65677).

just curious -- how did that ever end up in the distributed red hat
kernel if it was never standard?  strange.

rday

