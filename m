Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281459AbRKPRxz>; Fri, 16 Nov 2001 12:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKPRxg>; Fri, 16 Nov 2001 12:53:36 -0500
Received: from air-1.osdl.org ([65.201.151.5]:12444 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S281459AbRKPRxY>;
	Fri, 16 Nov 2001 12:53:24 -0500
Date: Fri, 16 Nov 2001 09:55:55 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Dave Jones <davej@suse.de>
cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Power Managment code
In-Reply-To: <Pine.LNX.4.30.0111161839040.22532-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0111160952090.21985-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Nov 2001, Dave Jones wrote:

> On Fri, 16 Nov 2001, James Simmons wrote:
>
> >   I heard Patrick Mochel has already developed the code for a new
> > device/power management syste. So I'm wondering where this code is. I like
> > to intergrate it into my CVS tree. Thanks.
>
> There were some bits at ftp://ftp.kernel.org/pub/people/mochel last time
> I looked.

That's where it is. The most recent drop is the -1115 patches.

I have some other patches converting drivers to use the new driver model,
and I will push those out soon..

However, that code does not have all the pieces to power management in it.
It simply provides a unified device tree based on locality; the framework
for doing things like system suspend.

The power management transitions live in the most recent ACPI code, which
you can get from Intel:

	http://developer.intel.com/technology/IAPC/acpi/index.htm

and is specific to ACPI-enabled platforms.

	-pat

