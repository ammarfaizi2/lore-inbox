Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUKCADC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUKCADC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUKCADB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:03:01 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:32777 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S262070AbUKCAC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:02:29 -0500
Date: Wed, 3 Nov 2004 00:01:29 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: adaplas@pol.net
cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
In-Reply-To: <200411030719.06138.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.10.10411022352380.5583-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just tested it and at the moment it does not. I suspect that
something needs to be registered in the 'panic_notifier_list' to do some
basic resets on the colour palette.

For the moment I will just ensure that colour 255 <> colour 0 by some
visible margin (Black/Dark Slate).

Mark.

On Wed, 3 Nov 2004, Antonino A. Daplas wrote:

> On Wednesday 03 November 2004 06:57, Mark Fortescue wrote:
> > Will this work for a kernel Panic ?
> >
> 
> Probably not, unless the 'Panic' tells fbcon to release the console and 
> tells promcon to take over the console again.  That in itself is problematic
> as fbcon cannot be safely unloaded yet.
> 
> Tony
> 
> 

