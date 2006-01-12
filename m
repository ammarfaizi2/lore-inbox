Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWAMRT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWAMRT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161567AbWAMRT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:19:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:60100 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161546AbWAMRT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:19:26 -0500
Date: Thu, 12 Jan 2006 14:47:34 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Message-ID: <20060112224734.GA18244@kroah.com>
References: <200601122241.07363.rjw@sisk.pl> <20060112220940.GA10088@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112220940.GA10088@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:09:40PM +0100, Pavel Machek wrote:
> > +commands defined in kernel/power/power.h.  The major and minor
> > +numbers of the device are, respectively, 10 and 231, and they can
> > +be read from /sys/class/misc/snapshot/dev.
> 
> Is this still true?

Yes, the driver core adds that "automagically" for you so tools like
udev know how to create the proper device node.

thanks,

greg k-h
