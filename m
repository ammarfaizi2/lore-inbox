Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUEJVVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUEJVVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUEJVUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:20:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:53209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261880AbUEJVUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:20:45 -0400
Date: Mon, 10 May 2004 14:19:59 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synchronous hotplug for kobjects
Message-ID: <20040510211959.GB10887@kroah.com>
References: <20040510204813.GA20691@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510204813.GA20691@dhcp193.mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 01:48:13PM -0700, Todd Poynor wrote:
> As discussed recently, it's expected to be useful to generate
> synchronous hotplug events from the kobject subsystem in certain
> situations.  This patch adds a kobject_hotplug_wait function that issues
> a synchronous call.  The function should be used for appropriate actions
> that require synchronous semantics; please note many hotplug events
> would suffer severe performance degradation if issued synchronously, and
> one should exercise caution in choosing to use this function.

How about I wait until someone really needs this function before adding
it?  Or do you have a patch that does need it?

thanks,

greg k-h
