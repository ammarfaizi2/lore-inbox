Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269569AbTGUOWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270136AbTGUOWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:22:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:53395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269569AbTGUOW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:22:29 -0400
Date: Mon, 21 Jul 2003 10:36:45 -0400
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, KML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: devfsd/2.6.0-test1
Message-ID: <20030721143645.GA9480@kroah.com>
References: <200307202117.32753.arvidjaar@mail.ru> <1058741336.19817.147.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058741336.19817.147.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 12:48:56AM +0200, Martin Schlemmer wrote:
> On Sun, 2003-07-20 at 19:17, Andrey Borzenkov wrote:
> > > Also, read the threads on the list about udev/hotplug - apparently
> > > devfsd is going out ...
> > 
> > as long as you have memory-based /dev you need devfsd even if it is called 
> > differently.
> >
> 
> I have not looked at it myself, but as far as I have it, you do not
> mount /dev, and just need udev/hotplug/libsysfs (not sure on libsysfs).
> Currently udev still call mknod, but I think Greg said he will fix that
> in the future.

What's wrong with calling mknod?

I did say I thought about calling sys_mknod directly from udev, but
that's just a minor change.  Is that what you were referring to?

thanks,

greg k-h
