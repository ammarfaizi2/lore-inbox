Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUCJXH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbUCJXDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:03:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:23771 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262881AbUCJW6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:58:05 -0500
Date: Wed, 10 Mar 2004 14:51:14 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040310225114.GD24336@kroah.com>
References: <20040303000957.GA11755@kroah.com> <404F1085.5080808@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F1085.5080808@gmx.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 01:56:37PM +0100, Prakash K. Cheemplavam wrote:
> Hi,
> 
> I have a problem with udev and my ZIP drive (using latest mm based kernel):
> 
> When I insert a zip the /dev for the partition doesn't get created (ie 
> hdd4, fdisk shows it though).
> 
> What is the problem?
> 
> 1) ATAPI Floppy lacks sysfs support?
> 2) I need to write some sort of rule?
> 3) Problem of udev?
> 4) something else?

Do you have udev creating all partitions for your hdd device?  That
sounds like the option that you need to use.

thanks,

greg k-h
