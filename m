Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUENSgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUENSgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUENSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:36:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:51674 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262029AbUENSgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:36:23 -0400
Date: Fri, 14 May 2004 11:34:50 -0700
From: Greg KH <greg@kroah.com>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: does udev support sw raid0?
Message-ID: <20040514183450.GA2345@kroah.com>
References: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 02:42:38PM -0300, Norberto Bensa wrote:
> Hello list,
> 
> I'm trying to setup my box to use udev but I'm stuck.
> 
> My /home partition is on a software raid0. Using devfs, I have no problems. I 
> can "mount /dev/md/0 /home" and I'm done, but udev seems to ignore raid0 
> completely. md and raid0 modules are loaded but there're no md/raid devices 
> on /dev.

Do your md raid devices show up in /sys/block?  If so, then udev should
support them.  If not, then udev will not.

thanks,

greg k-h
