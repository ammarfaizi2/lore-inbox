Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTKNNRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 08:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKNNRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 08:17:05 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:8383 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262570AbTKNNRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 08:17:00 -0500
Date: Fri, 14 Nov 2003 16:16:38 +0300
From: Alex Zarochentsev <zam@namesys.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: new reiser4 snapshot is available
Message-ID: <20031114131637.GK1278@backtop.namesys.com>
References: <20031113143438.GD1278@backtop.namesys.com> <20031114094217.GH1278@backtop.namesys.com> <1068807864.2883.1520.camel@lemsip> <20031114112027.GJ1278@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114112027.GJ1278@backtop.namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 02:20:28PM +0300, Alex Zarochentcev wrote:
> On Fri, Nov 14, 2003 at 12:04:25PM +0100, Gianni Tedesco wrote:
> > On Fri, 2003-11-14 at 10:42, Alex Zarochentsev wrote:
> > > > fetch it
> > > > http://namesys.com/snapshots/2003.11.12/linux-2.6.0-test9-reiser4.diff.gz
> > 
> > Seems to be combined with the UML patch...
> > 
> > zcat linux-2.6.0-test9-reiser4.diff.gz | diffstat
> >  Makefile                                                     |    2
> >  arch/i386/kernel/entry.S                                     |    4
> >  arch/i386/kernel/sys_i386.c                                  |    2
> >  arch/um/Kconfig                                              |   48
> >  arch/um/Kconfig_block                                        |   14
> >  arch/um/Kconfig_net                                          |   70
> >  arch/um/Makefile                                             |   49
> >  arch/um/Makefile-i386                                        |   20
> >  arch/um/Makefile-skas                                        |    6
> >  arch/um/config.release                                       |    1
> >  arch/um/defconfig                                            |  203
> >  arch/um/drivers/Makefile                                     |    6
> >  arch/um/drivers/chan_kern.c                                  |    1
> >  arch/um/drivers/chan_user.c                                  |    4
> > 
> > etc....
> 
> yes, this patch taken from our bk repository, 
> because UML is used in development, it contains uml fixes.
> 
> previous snapshot was done more carefully, it is located
> in http://namesys.com/snapshots/2003.10.17/ you can see 
> all changes in one patch as well as broken-out patches.
> 
> changes for test9 are the same as for test7 with minor exceptions. 

I made a cleanup for reiser4 patches (by removing UML-specific changes),
you can see result here: 

http://namesys.com/snapshots/2003.11.17/cleaned-up/

       core.diff.gz               - changes to the core kernel
       reiser4-only-diff.gz       - reiser4 code as a patch
       all.diff.gz                - all in one patch
       reiser4.tar.gz             - reiser4 bk repository (SCCS data included)

 
> > // Gianni Tedesco (gianni at scaramanga dot co dot uk)
> > lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
> > 8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

> -- 
> Alex.

-- 
Alex.
