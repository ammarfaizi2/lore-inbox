Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbTBFW0B>; Thu, 6 Feb 2003 17:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbTBFW0B>; Thu, 6 Feb 2003 17:26:01 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:2688 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267649AbTBFW0A>; Thu, 6 Feb 2003 17:26:00 -0500
Date: Thu, 6 Feb 2003 16:35:43 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Andreas Dilger <adilger@clusterfs.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: possible partition corruption
In-Reply-To: <20030206141415.J18636@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.44.0302061634430.863-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Andreas Dilger wrote:

> On Feb 06, 2003  15:05 -0600, Thomas Molina wrote:
> > On Thu, 6 Feb 2003, Andrew Morton wrote:
> > > Everything you describe is consistent with a kernel which does not have ext3
> > > compiled into it.
> > > 
> > > That is an ext3 filesystem in the "needs journal recovery" state.  ext2
> > > cannot mount that until either fsck or the ext3 kernel driver has run
> > > recovery.
> > 
> > I'm aware of that.  I attached the config file showing ext3 was compiled 
> > in.  I went through several iterations to ensure that having the proper 
> > filesystem compiled in was done.  
> 
> Maybe some config/linking breakage puts ext2 in front of ext3 in the probe
> order?  Try compiling with ext2 as a module.

Nope.  I still got the same symptoms.

