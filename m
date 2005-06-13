Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFMSRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFMSRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFMSRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:17:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:44181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261154AbVFMSQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:16:53 -0400
Date: Mon, 13 Jun 2005 11:15:42 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
Message-ID: <20050613181542.GB13025@kroah.com>
References: <1118476111230@kroah.com> <11184761113499@kroah.com> <20050611190515.GE3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611190515.GE3770@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 09:05:15PM +0200, Adrian Bunk wrote:
> On Sat, Jun 11, 2005 at 12:48:31AM -0700, Greg KH wrote:
> >...
> > --- gregkh-2.6.orig/drivers/block/acsi_slm.c	2005-06-10 23:48:38.000000000 -0700
> > +++ gregkh-2.6/drivers/block/acsi_slm.c	2005-06-10 23:48:51.000000000 -0700
> > @@ -1,5 +1,3 @@
> > -/*
> > - * acsi_slm.c -- Device driver for the Atari SLM laser printer
> >   *
> >   * Copyright 1995 Roman Hodek <Roman.Hodek@informatik.uni-erlangen.de>
> >   *
> >...
> 
> This part of the patch seems to be an accident.

Ah, good catch, it is.  Thanks, I've fixed it up now.

greg k-h
