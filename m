Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUCHOgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 09:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUCHOgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 09:36:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65195 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262492AbUCHOgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 09:36:13 -0500
Date: Mon, 8 Mar 2004 15:36:12 +0100
From: Jan Kara <jack@suse.cz>
To: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
Cc: Damian =?iso-8859-2?Q?Wojs=B3aw?= <damian.wojslaw@eltekenergy.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 + reiser + quota support
Message-ID: <20040308143612.GA19628@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0403051232470.3537-100000@118.eltek> <1078497744.27546.7.camel@blackbird.tecnoera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1078497744.27546.7.camel@blackbird.tecnoera.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2004-03-05 at 08:33, Damian Wojs³aw wrote:
> > > [root@test mnt]#
> > > and /var/log/messages says:
> > > Mar  4 19:15:46 test kernel: reiserfs_getopt: unknown option "usrquota"
> > 
> > 	If I remember correclty, reiserfs needs an additional patch to
> > support quota. I know this patch exists for 2.4.X kernels.
> 
> Yes, patches to support quota exist for 2.4.x kernels, because 2.4.x is
> not supposed to support quota for reiserfs in the vanilla distribution.
> Those patches are at
> ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4
> and work fine.
> 
> But kernel 2.6.x is supposed to support quota for ext2, ext3 _and_
> reiserfs without any patch. So I am doing something wrong (I hope), or
> there is a bug around here.
  Actually the text in Configure is a bit misleading. In 2.6 you also
need an additional patch for ReiserFS. Chris Mason created it a few days
ago so it might be available at his FTP..
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
