Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVH2InM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVH2InM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVH2InM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:43:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:16018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750768AbVH2InL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:43:11 -0400
Date: Mon, 29 Aug 2005 01:29:49 -0700
From: Greg KH <greg@kroah.com>
To: Karl Hiramoto <karl@hiramoto.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/workqueue.c:104!
Message-ID: <20050829082949.GC3565@kroah.com>
References: <430B48A5.4040702@hiramoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430B48A5.4040702@hiramoto.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 06:02:45PM +0200, Karl Hiramoto wrote:
> Hi,  i get this a lot now when doing:  "rmmod  cp2101 io_edgeport "

Why unload both modules?  Which device are you having problems with?

And can you duplicate this on a kernel that does not have a closed
source driver loaded into it?

If so, care to open a bug at bugzilla.kernel.org for this?

thanks,

greg k-h
