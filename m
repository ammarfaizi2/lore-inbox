Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUKPF61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUKPF61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUKPF44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:56:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:46555 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261911AbUKPFze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:55:34 -0500
Date: Mon, 15 Nov 2004 21:54:40 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041116055440.GH29328@kroah.com>
References: <20041109223729.GB7416@kroah.com> <d120d5000411091536115ac91b@mail.gmail.com> <20041110003323.GA8672@kroah.com> <200411092249.44561.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411092249.44561.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 10:49:43PM -0500, Dmitry Torokhov wrote:
> On Tuesday 09 November 2004 07:33 pm, Greg KH wrote:
> > All we have to do is rework that rwsem lock.  It's been staring at us
> > since the beginning of the driver core work, and we knew it would have
> > to be fixed eventually.  So might as well do it now.
> > 
> ...
> > 
> > So, off to rework this mess...
> > 
> 
> Do you have any ideas here? For me it seems that the semaphore has a dual
> role - protecting bus's lists and ensuring that probe/remove routines are
> serialized across bus...
> 
> In the meantime, can I please have bind_mode patch applied? I believe
> it is useful regardless of which bind/unbind solution will be adopted
> and having them will allow me clean up serio bus implementaion quite a
> bit.
> 
> Pretty please...

Care to resend it?  I can't find it in my archives.

thanks,

greg k-h
