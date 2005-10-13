Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVJMCM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVJMCM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVJMCMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:12:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:50318 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964864AbVJMCMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:12:21 -0400
Date: Wed, 12 Oct 2005 19:10:01 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051013021001.GA31737@kroah.com>
References: <20051013020844.GA31732@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 07:08:44PM -0700, Greg KH wrote:
> Ok, finally.  Here's a set of _working_ patches that properly implement
> nesting class_device structures, and the follow-on patches to move the
> input subsystem to use them.  Hotplug and release functions work
> properly now, and this will let us move /sys/block/ to use class and
> class_device structures soon.

Oh, Kay, do you have a public patch to udevstart/udev that can handle
this nested structure?  It might be good to have that so people can test
these in the next -mm.

thanks,

greg k-h
