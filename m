Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWAJBuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWAJBuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWAJBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:50:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932139AbWAJBuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:50:08 -0500
Date: Mon, 9 Jan 2006 17:49:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
Message-Id: <20060109174941.41b617f6.akpm@osdl.org>
In-Reply-To: <1136857742.14532.0.camel@localhost.localdomain>
References: <20060109203711.GA25023@kroah.com>
	<Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
	<20060109164410.3304a0f6.akpm@osdl.org>
	<1136857742.14532.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2006-01-09 at 16:44 -0800, Andrew Morton wrote:
> > - Reuben Farrelly's oops in make_class_name().  Could be libata, or scsi
> >   or driver core.
> 
> libata I think. I reproduced it on 2.6.14-mm2 by accident with a buggy
> pata driver.

Well that's all merged up now.  Reuben, could you please test 2.6.15git6
tomorrow?

