Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVCQFqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVCQFqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 00:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVCQFqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 00:46:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:55428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261902AbVCQFqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 00:46:11 -0500
Date: Wed, 16 Mar 2005 21:46:02 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] add TIMEOUT to firmware_class hotplug event
Message-ID: <20050317054602.GA14459@kroah.com>
References: <20050317023431.GA27777@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317023431.GA27777@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 03:34:31AM +0100, Kay Sievers wrote:
> On Tue, 2005-03-15 at 09:25 +0100, Hannes Reinecke wrote:
> > The current implementation of the firmware class breaks a fundamental
> > assumption in udevd: that the physical device can be initialised fully
> > prior to executing the next event for that device.
> 
> Here we add a TIMEOUT value to the hotplug environment of the firmware
> requesting event. I will adapt udevd not to wait for anything else, if
> it finds a TIMEOUT key.

Can't you just trigger off of the FIRMWARE variable instead?

thanks,

greg k-h
