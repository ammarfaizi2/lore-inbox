Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSGXOVJ>; Wed, 24 Jul 2002 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGXOVJ>; Wed, 24 Jul 2002 10:21:09 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:19607 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317327AbSGXOVI>; Wed, 24 Jul 2002 10:21:08 -0400
Date: Wed, 24 Jul 2002 09:24:15 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: David Woodhouse <dwmw2@infradead.org>
cc: John Levon <movement@marcelothewonderpenguin.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: kbuild - building a module/target from multiple directories 
In-Reply-To: <25869.1027516919@redhat.com>
Message-ID: <Pine.LNX.4.44.0207240923280.5872-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, David Woodhouse wrote:

> >  Basically, use only one Makefile and
> > 	blah-objs := blah_init.o blahstuff/blah1.o blahstuff/blah2.o ... 
> 
> Er, don't the dependencies get screwed then, because it fails to create 
> .blahstuff/blah1.o.flags, etc.?

No, just try it ;) (That's what I meant saying that I made it work...)

--Kai

