Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTJ2T3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbTJ2T3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:29:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:22968 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261380AbTJ2T3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:29:32 -0500
Date: Wed, 29 Oct 2003 11:18:58 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Message-ID: <20031029191858.GA4298@kroah.com>
References: <3F9D82F0.4000307@mvista.com> <20031027210054.GR24286@marowsky-bree.de> <3F9D8AAA.7010308@mvista.com> <20031028110034.GG30725@marowsky-bree.de> <1067364727.4612.359.camel@persist.az.mvista.com> <20031028224416.GA8671@kroah.com> <pan.2003.10.29.14.30.29.628488@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.10.29.14.30.29.628488@dungeon.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 03:30:30PM +0100, Andreas Jellinghaus wrote:
> ---cut---

Sweet shell script, nice job.

> So udev is 99% overhead?

To you, sure, it might be.  Don't use it then, I'm not forcing anyone.

> > 	SDE:	57328 lines
> > 	udev:	 9090 lines
>  shell script:     41 lines

Hm, how about the size of bash?

> > that udev is suffering from "lack of maintainability and bloat" if you
> > really want :)
> 
> bloat. lots of bloat. what is that tdb database for?
> filesystems are persistent. if you want to save space,
> create a tar file :-) 

Sweet, and then run everything on a in-ram compress filesystem just to
save that precious disk space.

> > p.s. yes, I know lines of code is a horrible metric, and doesn't really
> > mean squat.  I just want to point out the huge size difference between
> > the current state of udev and SDE, with pretty much identical
> > functionality from what I can tell.
> 
> I agree. lines of codes is a horrible metric, and comparing a shell
> script that uses many external commands to a c application with
> everything build is makes absolutely no sense. but I wonder why
> the off the shelf machine needs a c applications, if all those
> external commands are installed anyway.

Remember, userspace is just a load test for the kernel, who really needs
applications anyway.

</sarcasm>

greg k-h
