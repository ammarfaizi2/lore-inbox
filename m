Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261671AbSJCP0y>; Thu, 3 Oct 2002 11:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261191AbSJCP0s>; Thu, 3 Oct 2002 11:26:48 -0400
Received: from AGrenoble-101-1-1-129.abo.wanadoo.fr ([193.251.23.129]:65436
	"EHLO awak") by vger.kernel.org with ESMTP id <S261679AbSJCPZ4> convert rfc822-to-8bit;
	Thu, 3 Oct 2002 11:25:56 -0400
Subject: Re: RfC: Don't cd into subdirs during kbuild
From: Xavier Bestel <xavier.bestel@free.fr>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: kbuild-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210030954070.24570-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0210030954070.24570-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Oct 2002 17:31:17 +0200
Message-Id: <1033659077.2533.23.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 03/10/2002 à 16:56, Kai Germaschewski a écrit :

> > This would avoid recursive make, which isn't really a good idea (even if
> > it's used widely). Here is a good agument about that:
> > http://www.cse.iitb.ac.in/~soumen/teach/cs699a1999/make.html
> 
> I think I heard that before, but I would argue that recursive builds if 
> done right are just fine from the correctness point of view.

Then I would argue that recursive builds are a tradeoff between
speed/maintainability and correctness. Perhaps you should re-read this
paper then. Your patches go in the right direction, though.

