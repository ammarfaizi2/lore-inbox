Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTJQMJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbTJQMJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:09:59 -0400
Received: from intra.cyclades.com ([64.186.161.6]:56960 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263424AbTJQMJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:09:58 -0400
Date: Fri, 17 Oct 2003 09:12:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org,
       Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Subject: Re: LVM Snapshots
In-Reply-To: <200310151751.23103.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0310170910120.7586-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Oct 2003, Marc-Christian Petersen wrote:

> On Wednesday 15 October 2003 17:40, Christoph Pleger wrote:
> 
> Hi Christoph,
> 
> > I am using a 2.4.22 kernel from www.kernel.org together with an XFS
> > patch from SGI. I want to use LVM for creating snapshots for backups,
> > but I found out that I cannot mount the snapshots of journalling
> > filesystems (EXT3, XFS, Reiser). Only JFS snapshots can be mounted.
> > My research on internet gave the result that a kernel-patch must be used
> > to solve that problem, but I could not find such a patch for Linux
> > 2.4.22, so where can I get it?
> 
> Marcelo decided not to apply that needed patch. Here it is for you to play 
> with :) ... It'll apply with offsets to 2.4.23-pre7.

Because the patch touches generic fs code.

Dont use LVM with XFS for now.



