Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUCHQKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUCHQKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:10:21 -0500
Received: from baltazar.tecnoera.com ([200.24.224.1]:50613 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id S262515AbUCHQKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:10:15 -0500
Subject: Re: 2.6.3 + reiser + quota support
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Jan Kara <jack@suse.cz>
Cc: Damian =?iso-8859-2?Q?Wojs=B3aw?= <damian.wojslaw@eltekenergy.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040308143612.GA19628@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0403051232470.3537-100000@118.eltek>
	 <1078497744.27546.7.camel@blackbird.tecnoera.com>
	 <20040308143612.GA19628@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1078762136.5333.25.camel@blackbird.tecnoera.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 08 Mar 2004 13:08:57 -0300
Content-Transfer-Encoding: 8bit
X-tecnoera-MailScanner-Information: Please contact the ISP for more information
X-tecnoera-MailScanner: Found to be clean
X-MailScanner-From: jpabuyer@tecnoera.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-08 at 11:36, Jan Kara wrote:
> > On Fri, 2004-03-05 at 08:33, Damian Wojs³aw wrote:
> > > > [root@test mnt]#
> > > > and /var/log/messages says:
> > > > Mar  4 19:15:46 test kernel: reiserfs_getopt: unknown option "usrquota"
> > > 
> > > 	If I remember correclty, reiserfs needs an additional patch to
> > > support quota. I know this patch exists for 2.4.X kernels.
> > 
> > Yes, patches to support quota exist for 2.4.x kernels, because 2.4.x is
> > not supposed to support quota for reiserfs in the vanilla distribution.
> > Those patches are at
> > ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4
> > and work fine.
> > 
> > But kernel 2.6.x is supposed to support quota for ext2, ext3 _and_
> > reiserfs without any patch. So I am doing something wrong (I hope), or
> > there is a bug around here.
>   Actually the text in Configure is a bit misleading. In 2.6 you also
> need an additional patch for ReiserFS. Chris Mason created it a few days
> ago so it might be available at his FTP..
> 								Honza

that would be it
ftp://ftp.suse.com/pub/people/mason/patches/data-logging/experimental/2.6.3

Thanks!

ps: how much should I be intimidated by that "experimental" directory
name?

