Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWIGNNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWIGNNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWIGNNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:13:12 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:746 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751811AbWIGNNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:13:11 -0400
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: Victor Hugo <victor@vhugo.net>, linux-kernel@vger.kernel.org,
       Victor Castro <victorhugo83@yahoo.com>
In-Reply-To: <1157560971.5265.94.camel@perihelion>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
	 <1157441620.24916.5.camel@localhost>
	 <508B6A67-CA5B-4A81-B868-BF8A03D78888@vhugo.net>
	 <1157560971.5265.94.camel@perihelion>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 17:10:26 +0200
Message-Id: <1157641826.30159.99.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

> > > actually it has never been really a filename. It was a simple pattern
> > > that the initial hotplug script and later the udev script mapped  
> > > 1:1 to a filename on your filesystem. If you check the mailing list  
> > > archives of LKML and linux-hotplug you will see that I always resisted
> > > in allowing drivers to include a directory path in that call. A couple
> > > of people tried this and it is not what it was meant to be.
> 
> That's fine. I agree with the idea - *but* it strikes me that we don't
> really have a co-ordinated database of what module "patterns" map to
> what on-disk firmware, aside from hotplug/udev scripts. We need to
> co-ordinate this stuff a lot more. Or am I missing something? I'm happy
> to setup a database on the kerneltools.org wiki if that's useful...

that is true, but it is actually not a problem of the kernel and your
proposed MODULE_FIRMWARE patch. However it might be a good idea to start
something like this. It will also help to see what is actually needed.

> I'm trying to avoid the need to have lots of different places in
> userland needing to track firmware versioning. But on some level, I just
> need to know that a given driver is going to ask for 1 firmware with the
> ID of "foo" - and a way to extrapolate where it is on disk to package.

Let start collecting these information and then go from there.

Regards

Marcel


