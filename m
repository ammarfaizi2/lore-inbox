Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270863AbTGVNwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270847AbTGVNuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:50:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:52899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270850AbTGVNto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:49:44 -0400
Date: Tue, 22 Jul 2003 07:08:52 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>,
       <ole.rohne@cern.ch>
Subject: Re: More powermanagment hooks for pci
In-Reply-To: <20030721221205.GJ436@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0307220707510.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I know. I'm thinking of adding power_{off,on} to the core and getting rid
> > of the level parameter to the suspend/resume functions (like how I changed
> > system devices). That would require an additional hook to the PCI drivers
> > so that the call is propogated down to the low-level driver. If that's the
> > case, then we should add both to struct pci_driver at once.
> 
> Should I modify patch to add both?

No, don't bother yet. 


	-pat

