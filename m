Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262146AbSJASst>; Tue, 1 Oct 2002 14:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSJASr6>; Tue, 1 Oct 2002 14:47:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17809 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262209AbSJASrR>;
	Tue, 1 Oct 2002 14:47:17 -0400
Date: Tue, 1 Oct 2002 11:54:43 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] driverfs multi-node(board) patch [2/2]
In-Reply-To: <3D99ED03.8040600@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210011153240.27710-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I have some comments about the structure of the code, but those will come 
> > in another email..
> Cool...  Any/all comments are definitely welcome...

You'll have to wait prolly 1 more day, though. Sorry..

> > Shouldn't nodes (or, erm, boards) be added as children of the root? 
> Um, yes!  I don't quite know how, though...  I call sys_register_root() 
> for each of the nodes...  That call seems to parent them under the 
> root/sys directory...  How can I change that?

Woops. That sounds like my booboo. I'll look into that.

> > Aren't all types of devices present on the various boards (PCI, etc)?
> Yes...  I have some patches that I'm working that will put PCI busses 
> and devices into the topology infrastructure (both in-kernel & via 
> driverfs).  Again, this is just a first pass of what I'd like to see... ;)

Sweet, that should be cool.

	-pat

