Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUJVXhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUJVXhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbUJVXfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:35:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:7595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269259AbUJVXdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:33:03 -0400
Date: Fri, 22 Oct 2004 16:32:18 -0700
From: Greg KH <greg@kroah.com>
To: Ari Pollak <aripollak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev doesn't add a device for one of my partitions under 2.6.9
Message-ID: <20041022233218.GA28032@kroah.com>
References: <clbgip$63d$1@sea.gmane.org> <20041022230209.GA26748@kroah.com> <41799760.4090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41799760.4090403@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-kernel back to the CC: so that people can see the
resolution]

On Fri, Oct 22, 2004 at 07:27:28PM -0400, Ari Pollak wrote:
> Greg KH wrote:
> >Does /sys/block/hda/ show partition the partition you are missing?  If
> >not, there's no way that udev could know to create it.
> 
> It does indeed show hda5 and all of the appropriate information inside 
> of it.
> I just upgraded udev to 0.40 and did a /etc/init.d/udev restart, and 
> /dev/hda5 magically appeared. Weird, I guess it really was a userspace 
> issue.

Glad it's working out for you.

greg k-h
