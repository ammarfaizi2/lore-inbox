Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVCRAUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVCRAUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCRAUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:20:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:56503 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261412AbVCRAUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:20:12 -0500
Date: Thu, 17 Mar 2005 15:56:09 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] add TIMEOUT to firmware_class hotplug event
Message-ID: <20050317235609.GA7289@kroah.com>
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
> 
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

Applied, thanks.

greg k-h
