Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVGINES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVGINES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVGINER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:04:17 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:52516 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261364AbVGINEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:04:15 -0400
X-IronPort-AV: i="3.94,183,1118034000"; 
   d="scan'208"; a="264074007:sNHT17575720"
Date: Sat, 9 Jul 2005 08:04:14 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>,
       Jon Smirl <jonsmirl@gmail.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC][PATCH 2.6.13-rc1] driver core: subclasses
Message-ID: <20050709130414.GA6362@lists.us.dell.com>
References: <20050708225448.GA18193@lists.us.dell.com> <20050709024000.GA7608@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709024000.GA7608@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 07:40:00PM -0700, Greg KH wrote:
> On Fri, Jul 08, 2005 at 05:54:48PM -0500, Matt Domsch wrote:
> > The below patch is a first pass at implementing subclasses, for review
> > and comment.
> 
> Oops, when you mentioned this on irc, I thought you were referring to
> class_devices not classes.  I don't want classes to be able to be
> nested, only class devices.
> 
> I don't see a need for nested classes, as I thought the input thread had
> resolved itself so that it didn't need it (but I stopped paying
> attention, sorry, so I might be wrong here...)

The tailing part of the thread is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111873628324649&w=2
http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=111877313202313&w=2
where Hannes and Dmitry seemed to indicate (to my reading) that they
were looking for subclasses.  Perhaps it's not necessary.

> Why can't you just use class_device's that can have children?  That way
> the /sys/block stuff could be converted to also use this.

I will investigate.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
