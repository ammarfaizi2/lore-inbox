Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSHOC1F>; Wed, 14 Aug 2002 22:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSHOC1F>; Wed, 14 Aug 2002 22:27:05 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:56771 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316499AbSHOC1F>; Wed, 14 Aug 2002 22:27:05 -0400
Date: Wed, 14 Aug 2002 21:30:47 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Alan Cox <alan@redhat.com>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2-ac1
In-Reply-To: <200208150114.g7F1EcY25108@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0208142120000.849-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Alan Cox wrote:

> > - drivers/isdn/hisax/st5481.h
> > 	Usage of '...' in macro, not always compatible with prevailing
> > 	versions of gcc. We all know the story though... I just disabled
> > 	all the special macros for now
> 
> I'll ifdef between the two versions again. I'm not using the old gcc on
> any boxes nowdays so I don't catch them

There surely has to be a way to get that working on all compilers? I seem
to remember that adding a space after __FUNCTION__ was necessary in some
cases (before the ','). Alas I don't have anything newer than 2.96 for 
testing here.

--Kai

