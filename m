Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTJQOSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbTJQOSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:18:05 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:56450 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263430AbTJQOSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:18:02 -0400
Date: Fri, 17 Oct 2003 16:18:01 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: LVM Snapshots
Message-Id: <20031017161801.140b8368.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <Pine.LNX.4.44.0310170910120.7586-100000@logos.cnet>
References: <200310151751.23103.m.c.p@wolk-project.de>
	<Pine.LNX.4.44.0310170910120.7586-100000@logos.cnet>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ello,

On Fri, 17 Oct 2003 09:12:30 -0200 (BRST)
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:


> > > I am using a 2.4.22 kernel from www.kernel.org together with an
> > > XFS patch from SGI. I want to use LVM for creating snapshots for
> > > backups, but I found out that I cannot mount the snapshots of
> > > journalling filesystems (EXT3, XFS, Reiser). Only JFS snapshots
> > > can be mounted. My research on internet gave the result that a
> > > kernel-patch must be used to solve that problem, but I could not
> > > find such a patch for Linux 2.4.22, so where can I get it?
> > 
> > Marcelo decided not to apply that needed patch. Here it is for you
> > to play with :) ... It'll apply with offsets to 2.4.23-pre7.
> 
> Because the patch touches generic fs code.
> 
> Dont use LVM with XFS for now.

I have used them together. The only thing that made problems at first
after applying the LVM-patch was that I did not know that the special
option "nouuid" is needed when mounting an XFS-Snapshot. But afterwards
I had no problem so far. 

So why do you think that I should not use XFS on a logical volume?

Christoph
