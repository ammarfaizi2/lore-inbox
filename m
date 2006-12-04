Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935390AbWLDKDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935390AbWLDKDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935399AbWLDKDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:03:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42931 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935390AbWLDKDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:03:02 -0500
Subject: Re: [GFS2] Change argument of gfs2_dinode_out [17/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1165000744.1194.89.camel@xenon.msp.redhat.com>
References: <1164888933.3752.338.camel@quoit.chygwyn.com>
	 <1165000744.1194.89.camel@xenon.msp.redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Dec 2006 10:05:08 +0000
Message-Id: <1165226708.3752.608.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 13:19 -0600, Russell Cattelan wrote:
> On Thu, 2006-11-30 at 12:15 +0000, Steven Whitehouse wrote:
> > >From 539e5d6b7ae8612c0393fe940d2da5b591318d3d Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Tue, 31 Oct 2006 15:07:05 -0500
> > Subject: [PATCH] [GFS2] Change argument of gfs2_dinode_out
> > 
> > Everywhere this was called, a struct gfs2_inode was available,
> > but despite that, it was always called with a struct gfs2_dinode
> > as an argument. By making this change it paves the way to start
> > eliminating fields duplicated between the kernel's struct inode
> > and the struct gfs2_dinode.
> More pointless code churn.
> 
> This only makes sense once the file system is working 
> and we have time to do this type of cleanup on against
> a stable and TESTED code base.
> 
I disagree and refer you to the comments from Al Viro and Pavel Machek
on this subject,

Steve.


