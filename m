Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUIYEgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUIYEgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 00:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269236AbUIYEgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 00:36:16 -0400
Received: from digitalimplant.org ([64.62.235.95]:12975 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S269233AbUIYEgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 00:36:14 -0400
Date: Fri, 24 Sep 2004 21:36:05 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org, "" <greg@kroah.com>
Subject: Re: [BK] Changing driver core/sysfs/kobject symbol exports to GPL
 only
In-Reply-To: <200409242324.38923.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.50.0409242133480.19236-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0409241202110.30766-200000@monsoon.he.net>
 <200409242324.38923.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Sep 2004, Dmitry Torokhov wrote:

> On Friday 24 September 2004 10:42 pm, Patrick Mochel wrote:
> > What's life without a little controversey once in a while?
> >
> > The attached patch and referenced BK tree changes all the symbol exports
> > in the driver core, sysfs, and the kobject core to EXPORT_SYMBOL_GPL [1].
>
> May I ask to keep class_simple and maybe platform_device_register_simple
> available to non-GPL modules. These functions offer limited and documented
> semantic and while it is impossible to build entire new subsystem around
> them it will allow non-GPL stuff still be somewhat integrated - standard
> hotplug mostly I think...

I didn't touch class_simple. Are there really external modules that use
platform_device_register_simple(), or you speaking hypothetically?

IOW, this is a call to anyone that has external modules (that aren't GPL)
to step up and claim usage and make arguments for their non-GPL
exportability.


	Pat
