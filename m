Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWIULbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWIULbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 07:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWIULbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 07:31:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:29911 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750940AbWIULbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 07:31:20 -0400
Date: Thu, 21 Sep 2006 04:30:10 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: drivers/char/random.c exported interfaces
Message-ID: <20060921113010.GA3756@suse.de>
References: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com> <200609210011.25891.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609210011.25891.dtor@insightbb.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 12:11:25AM -0400, Dmitry Torokhov wrote:
> On Wednesday 20 September 2006 13:04, Robin Getz wrote:
> > Randy Dunlap said:
> > >ISTM that we should at least fix the first 2 (by EXPORTing them).
> > >or we don't allow INPUT=m.
> > >
> > >You want to send a patch?
> > 
> > No problem - which patch do you want? (exporting? or set INPUT to bool?)
> > 
> > I'll send the export later tonight if no objections.
> >
> 
> Would there be any objections if I commit the patch below so input
> could be built as a module? 
> 
> -- 
> Dmitry
> 
> Input: fix building input core as a module
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

No objection from me, feel free to add:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

to this patch.

thanks,

greg k-h
