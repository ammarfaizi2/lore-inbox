Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWAZQZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWAZQZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWAZQZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:25:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20400 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964790AbWAZQZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:25:02 -0500
Date: Thu, 26 Jan 2006 08:24:56 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Olaf Hering <olh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Zone reclaim: proc override
In-Reply-To: <20060126140719.GA10099@suse.de>
Message-ID: <Pine.LNX.4.62.0601260824420.14865@schroedinger.engr.sgi.com>
References: <200601190413.k0J4DjdQ021200@hera.kernel.org> <20060126140719.GA10099@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Olaf Hering wrote:

>  On Wed, Jan 18, Linux Kernel Mailing List wrote:
> 
> > +++ b/kernel/sysctl.c
> 
> > +#ifdef CONFIG_NUMA
> > +	{
> > +		.ctl_name	= VM_ZONE_RECLAIM_MODE,
> 
> > +		.strategy	= &zero,
> 
> zero is an 'int', while strategy is ctl_handler *.

Right. The fix is in Andrew's tree.

