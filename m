Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbUCKBpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbUCKBoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:44:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:26029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262944AbUCKBnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:43:25 -0500
Date: Wed, 10 Mar 2004 17:21:27 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040311012127.GC11828@kroah.com>
References: <20040303000957.GA11755@kroah.com> <404F1085.5080808@gmx.de> <20040310225114.GD24336@kroah.com> <404FA1F8.9060306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404FA1F8.9060306@gmx.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 12:17:12AM +0100, Prakash K. Cheemplavam wrote:
> Greg KH wrote:
> >On Wed, Mar 10, 2004 at 01:56:37PM +0100, Prakash K. Cheemplavam wrote:
> >>I have a problem with udev and my ZIP drive (using latest mm based 
> >>kernel):
> >>
> >>When I insert a zip the /dev for the partition doesn't get created (ie 
> >>hdd4, fdisk shows it though).
> >
> >Do you have udev creating all partitions for your hdd device?  That
> >sounds like the option that you need to use.
> >
> 
> Nope, I don't have any special udev treatment for that device. Could you 
> give me a clearer hint (docs?)? :-) I guess something about udev.rules?

See the manpage for udev and look at the NAME{all_partitions} section.

Good luck,

greg k-h
