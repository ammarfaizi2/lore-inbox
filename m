Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUAUANh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUAUANh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:13:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:61602 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263963AbUAUAN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:13:26 -0500
Date: Tue, 20 Jan 2004 16:10:09 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Driver Core update for 2.6.1
Message-ID: <20040121001009.GM4923@kroah.com>
References: <20040120011036.GA6162@kroah.com> <yw1xsmibovwp.fsf@ford.guide> <20040120171435.GE18566@kroah.com> <yw1x8yk2o6il.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x8yk2o6il.fsf@ford.guide>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 06:48:50PM +0100, Måns Rullgård wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Tue, Jan 20, 2004 at 09:40:22AM +0100, Måns Rullgård wrote:
> >> Greg KH <greg@kroah.com> writes:
> >> 
> >> >   o ALSA: add sysfs class support for ALSA sound devices
> >> 
> >> This is still only completed for the intel8x0 driver, right?
> >
> > The "device" and "driver" symlink will only show up for that driver,
> > yes.  But the class support will work for all alsa devices.  Now we can
> > add 1 line patches for all of the alsa drivers to enable those
> > symlinks...
> 
> I see.
> 
> BTW, I still don't get a snd/controlC0 in /udev.  All the other ALSA
> devices are there.

Is there for me :)

What does /sys/class/sound show for you?

thanks,

greg k-h
