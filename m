Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUE1PD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUE1PD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUE1PD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:03:27 -0400
Received: from thunk.org ([140.239.227.29]:49638 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263375AbUE1PD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:03:26 -0400
Date: Fri, 28 May 2004 11:01:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chris Shoemaker <c.shoemaker@cox.net>
Cc: Mark Watts <m.watts@eris.qinetiq.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Message-ID: <20040528150119.GE18449@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Chris Shoemaker <c.shoemaker@cox.net>,
	Mark Watts <m.watts@eris.qinetiq.com>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com> <20040528062141.GA18118@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528062141.GA18118@cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 02:21:41AM -0400, Chris Shoemaker wrote:
> > Agreed - fmirror is so much more reliable than rsync (imho) that it makes 
> > rsync into a worst-case option for retrieving files.
> 
>   bug reports to rsync@lists.samba.org are appreciated...
> 

The main problem with rsync that I can see is that it is fairly heavy
weight on the server, so many servers (including mirrors.kernel.org)
have a maximum number of connections set to something pathetically
small, like say 5 connections.  

I remember Tridge trying to get someone to implement checksum caching
for rsync servers some 4+ years ago, which would surely help.  Did
that ever get done?  If so, convincing the server admins that it's OK
to up the maximum number of rsync connections would be the next step.

						- Ted
