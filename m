Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbUKPXPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUKPXPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUKPXMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:12:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:45218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261890AbUKPXKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:10:51 -0500
Date: Tue, 16 Nov 2004 15:08:28 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041116230828.GB16690@kroah.com>
References: <20041109223729.GB7416@kroah.com> <d120d5000411091536115ac91b@mail.gmail.com> <20041110003323.GA8672@kroah.com> <200411092249.44561.dtor_core@ameritech.net> <20041116055440.GH29328@kroah.com> <d120d50004111612437ebe76d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50004111612437ebe76d9@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 03:43:21PM -0500, Dmitry Torokhov wrote:
> On Mon, 15 Nov 2004 21:54:40 -0800, Greg KH <greg@kroah.com> wrote:
> > On Tue, Nov 09, 2004 at 10:49:43PM -0500, Dmitry Torokhov wrote:
> > > In the meantime, can I please have bind_mode patch applied? I believe
> > > it is useful regardless of which bind/unbind solution will be adopted
> > > and having them will allow me clean up serio bus implementaion quite a
> > > bit.
> > >
> > > Pretty please...
> > 
> > Care to resend it?  I can't find it in my archives.
> > 
> 
> Here it is, against 2.6.10-rc2. Apologies for sending it as an attachment
> but this interface will not let me put it inline without mangling.

No, for now, if you want to do this, do it in the serio code only, let's
clean up the locking first before we do this in the core.

thanks,

greg k-h
