Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274869AbTHPQhP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTHPQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:37:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:11943 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274869AbTHPQhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:37:11 -0400
Date: Sat, 16 Aug 2003 09:37:27 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 current - compile error - no member named 'name'
Message-ID: <20030816163727.GC9735@kroah.com>
References: <3F3E288B.3010105@cornell.edu> <3F3DD93E.7090706@myrealbox.com> <3F3E38AE.1040902@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3E38AE.1040902@cornell.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 09:59:10AM -0400, Ivan Gyurdiev wrote:
> walt wrote:
> >Ivan Gyurdiev wrote:
> >
> >>Hopefully, this is not a duplicate post:
> >>===========================================
> >>
> >>drivers/ieee1394/nodemgr.c: In function `nodemgr_update_ud_names':
> >>drivers/ieee1394/nodemgr.c:471: error: structure has no member named 
> >>`name'
> >
> >
> >I got a similar error starting with last night's bk pull:
> >
> >drivers/pnp/core.c: In function `pnp_register_protocol':
> >drivers/pnp/core.c:72: structure has no member named `name'
> >
> >-
> 
> And I just got another one of those trying to compile the nvidia driver 
> for this kernel. So apparently this is not firewire or pnp specific.

Well go bug nvidia about that, nothing we can do for closed source
modules...

thanks,

greg k-h
