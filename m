Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbUATBv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUATBr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:47:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:17620 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265320AbUATBn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:43:27 -0500
Date: Mon, 19 Jan 2004 17:30:42 -0800
From: Greg KH <greg@kroah.com>
To: Martin Mares <mj@ucw.cz>
Cc: Kieran Morrissey <linux@mgpenguin.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for long device names.
Message-ID: <20040120013042.GG6309@kroah.com>
References: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net> <20040117103859.GA2185@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117103859.GA2185@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 11:39:00AM +0100, Martin Mares wrote:
> Hello!
> 
> > * Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as at 
> > 14 Jan 04.
> > * Fixes gen-devlist.c to truncate long device names rather than reject the 
> > whole database
> >   (previously the latest databases had some devices that were too long and 
> > caused a kernel with the latest db to fail to compile)
> 
> I think it would be better to increase the name length limit, the long entries
> really have useful information at the end :)

That's probably a good idea.  Kieran, care to make up a patch to do
this?

thanks,

greg k-h
