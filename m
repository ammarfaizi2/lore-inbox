Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbSJCOvc>; Thu, 3 Oct 2002 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSJCOvc>; Thu, 3 Oct 2002 10:51:32 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:15761 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261498AbSJCOvb>; Thu, 3 Oct 2002 10:51:31 -0400
Date: Thu, 3 Oct 2002 09:56:56 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Xavier Bestel <xavier.bestel@free.fr>
cc: kbuild-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RfC: Don't cd into subdirs during kbuild
In-Reply-To: <1033633277.27227.2.camel@nomade>
Message-ID: <Pine.LNX.4.44.0210030954070.24570-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Oct 2002, Xavier Bestel wrote:

> Could you do instead:
> 
> 	include subdir/Makefile
> ?

It's not quite that easy, unfortunately ;(

> This would avoid recursive make, which isn't really a good idea (even if
> it's used widely). Here is a good agument about that:
> http://www.cse.iitb.ac.in/~soumen/teach/cs699a1999/make.html

I think I heard that before, but I would argue that recursive builds if 
done right are just fine from the correctness point of view.

--Kai


