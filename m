Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266035AbUFDW63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUFDW63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266046AbUFDW44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:56:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:56010 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266035AbUFDWwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:52:39 -0400
Date: Fri, 4 Jun 2004 15:51:35 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Module section offsets in /sys/module
Message-ID: <20040604225135.GA14176@kroah.com>
References: <20040603213946.31209.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603213946.31209.qmail@lwn.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 03:39:46PM -0600, Jonathan Corbet wrote:
> 
> Currently, this feature is absent if CONFIG_KALLSYMS is not set.  I do
> wonder if CONFIG_DEBUG_INFO might not be a better choice, now that I think
> about it.  Section names are unmunged, so "ls -a" is needed to see most of
> them. 
> 
> Applies to 2.6.7-rc2.  Comments?

Nice, I like this.  I've added it to my driver-2.6 tree to have it show
up in the next -mm release.

If you want to change the config option, feel free to send a patch on
top of this one.

thanks,

greg k-h
