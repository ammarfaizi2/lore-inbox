Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWIOXDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWIOXDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWIOXDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:03:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:49627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932351AbWIOXDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:03:11 -0400
Date: Fri, 15 Sep 2006 15:57:34 -0700
From: Greg KH <greg@kroah.com>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH 15/25] dm: add uevent change event on resume
Message-ID: <20060915225734.GA15816@kroah.com>
References: <20060914214729.GW3928@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914214729.GW3928@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 10:47:29PM +0100, Alasdair G Kergon wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Device-mapper devices are not accessible until a 'resume' ioctl has been
> issued.  For userspace to find out when this happens we need to generate an
> uevent for udev to take appropriate action.
> 
> As discussed at OLS we should send 'change' events for 'resume'.
> We can think of no useful purpose served by also having 'suspend' events.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
> Signed-off-by: Alasdair G Kergon <agk@redhat.com>

I was at that meeting for a bit (had to chase after my son...) so feel
free to add:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

from me to this patch.

thanks,

greg k-h
