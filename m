Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbSITJSS>; Fri, 20 Sep 2002 05:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbSITJSR>; Fri, 20 Sep 2002 05:18:17 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:23682 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261944AbSITJSQ>; Fri, 20 Sep 2002 05:18:16 -0400
Message-Id: <200209200923.g8K9NKl04604@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: Padraig Brady <padraig.brady@corvil.com>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext3 fs: no userspace writes == no disk writes ? 
In-Reply-To: Message from Padraig Brady <padraig.brady@corvil.com> 
   of "Fri, 20 Sep 2002 10:15:05 BST." <3D8AE719.5000901@corvil.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 20 Sep 2002 11:23:20 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rob van Nieuwkerk wrote:
> > Hi Pádraig,
> > 
> > Pádraig Brady wrote:
> > 
> >>Rob van Nieuwkerk wrote:
> >>
> >>>Hi Alan,
> >>>
> >>>
> >>>>On Fri, 2002-09-20 at 00:04, Andrew Morton wrote:
> >>>>
> >>>>
> >>>>>There are frequently written areas of an ext3 filesystem - the
> >>>>>journal, the superblock.  Those would wear out pretty quickly.
> >>>>
> >>>>CF is -supposed- to wear level.
> >>>
> >>>Yes I know.
> >>>
> >>>But I haven't been able to find any specs from any CF manufacturer
> >>>about this mechanism, percentage of spare sectors or number of allowed
> >>>write-cycles in general.
> >>
> >>me either.
> >>
> >>Why don't you just mount the fs ro ?
> >>
> >>Pádraig
> > 
> > 
> > Ehm .., because I need to store data on it ..
> 
> Ehm, well remount,rw before you store data on it
> and remount,ro when finished?
> 
> Pádraig.

Will think about it.  Wondering how much this would impact performance
(in my application).

	greetings,
	Rob van Nieuwkerk
