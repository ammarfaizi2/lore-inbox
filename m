Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVJRHk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVJRHk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbVJRHk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:40:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:50366 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751454AbVJRHkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:40:55 -0400
Date: Tue, 18 Oct 2005 00:40:29 -0700
From: Greg KH <greg@kroah.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051018074029.GC12406@kroah.com>
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org> <20051017132242.2b872b08.akpm@osdl.org> <20051018065843.GB11858@kroah.com> <4354A49B.6060809@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4354A49B.6060809@ens-lyon.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 09:30:35AM +0200, Brice Goglin wrote:
> Le 18.10.2005 08:58, Greg KH a ?crit :
> > I know this patch doesn't have the proc path, but it does fix an easy
> > oops that I can generate from sysfs input devices.  Can you try it out
> > to see if it fixes your issue too?
> > 
> > thanks,
> > 
> > greg k-h
> 
> No sorry, it doesn't fix my oops.
> 
> By the way, your patch didn't apply to my rc4-mm1 tree.
> The one I had to apply is attached.
> 
> I might add some debugging code into my tree to help debugging.
> But, you'll have to tell what code and where :)

If you disable CONFIG_PNP, does the oops go away?

Also, does this oops keep you from booting?  If not, can you see what
the output of 'cat /proc/bus/input/devices' produces (it should show
what device is dying on us.)

thanks,

greg k-h
