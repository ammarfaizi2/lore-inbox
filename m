Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSJWN6v>; Wed, 23 Oct 2002 09:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265011AbSJWN6v>; Wed, 23 Oct 2002 09:58:51 -0400
Received: from 62-190-200-107.pdu.pipex.net ([62.190.200.107]:10244 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S265008AbSJWN6u>; Wed, 23 Oct 2002 09:58:50 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210231414.g9NEELVr004557@darkstar.example.net>
Subject: Re: 2.5 Problem Report Status
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 23 Oct 2002 15:14:20 +0100 (BST)
Cc: tmolina@cox.net, erik@debill.org, linux-kernel@vger.kernel.org
In-Reply-To: <1035378581.4033.45.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Oct 23, 2002 02:09:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >                                2.5 Kernel Problem Reports as of 22 Oct
> > >    Status                 Discussion  Problem Title
> > >
> > > --------------------------------------------------------------------------
> > >    open                   17 Oct 2002 IDE not powered down on shutdown
> > >   55. http://marc.theaimsgroup.com/?l=linux-kernel&m=103476420012508&w=2
> > > 
> > > --------------------------------------------------------------------------
> > >
> > > --------------------------------------------------------------------------
> > >    open                   22 Oct 2002 2.5.44 fs corruption
> > >   77. http://marc.theaimsgroup.com/?l=linux-kernel&m=103532467828806&w=2
> > > 
> > > --------------------------------------------------------------------------
> > 
> > Any possibility that the above two problems are related - I.E. disks
> > are not being flushed properly on shutdown?
> 
> Possibly. I would be suprised however

Alan - have there been any changes to the flush/spindown code between
2.5.42 and 2.5.44?  I remember a discussion about a month ago where
you said that it's necessary to do both, but that the order could be
wrong.  I am seriously begining to suspect that something is
definitely wrong, because I can actually hear the disk spindown for a
fraction of a second, then spin up again, (at least with 2.5.43, so
far not with 2.5.44).

John.
