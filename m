Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTJ2WaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJ2WaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:30:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:49053 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261680AbTJ2WaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:30:08 -0500
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031029191858.GA4298@kroah.com>
References: <3F9D82F0.4000307@mvista.com>
	 <20031027210054.GR24286@marowsky-bree.de> <3F9D8AAA.7010308@mvista.com>
	 <20031028110034.GG30725@marowsky-bree.de>
	 <1067364727.4612.359.camel@persist.az.mvista.com>
	 <20031028224416.GA8671@kroah.com>
	 <pan.2003.10.29.14.30.29.628488@dungeon.inka.de>
	 <20031029191858.GA4298@kroah.com>
Content-Type: text/plain
Organization: small linux home
Message-Id: <1067465573.28173.33.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 29 Oct 2003 23:12:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!

On Wed, 2003-10-29 at 20:18, Greg KH wrote:
> Sweet shell script, nice job.
> 
> > So udev is 99% overhead?
> To you, sure, it might be.  Don't use it then, I'm not forcing anyone.

Thats right! So I don't understand all those discussions why some people
created an alternative to udev, as everyone is free to. All
implementations seem to be quit young, and I enjoy many different
approaches to solve these related problems. a bit of diversity or
evolution and natural selection doesn't hurt.

But, all these different user space tools share one thing: the same
kernel. the linux kernel has to work for all of us, and I even think
it is very important to have many different user space tools at the
current time, so everyone can voice their opinions and suggest how the
kernel should be changed, so it will work for him, and preferable for
all of us.

Now, I'd love if the kernel would keep the permissions that devfs
has. you don't. nobody else wrote something about it? but that issue
isn't that important.

I'd like to see a different namespace. I need some info on
block devices. currently there is no way to see if hdc is
a cdrom or a disc in sysfs, so that should be added.

how do you call that distinction cdrom/disc? type? class? I don't now.
I was under the impression, that this should be part of the path to
the dev file, i.e. cdroms should be in a cdrom/ directory and 
discs in a disc/ directory. would that be a major change?

the alternative would be an additional attribute to the kobject
with that information. 

I'm no kernel hacker, I can bareley understand some parts of the code
and do trivial changes. But I will try to learn more and maybe be
of some help.

Andreas

