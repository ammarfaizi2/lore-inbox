Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUEKXvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUEKXvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUEKXsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:48:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:11747 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265068AbUEKXpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:45:40 -0400
Date: Tue, 11 May 2004 16:00:01 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
Message-ID: <20040511230001.GA26569@kroah.com>
References: <20040511010015.GA21831@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511010015.GA21831@dhcp193.mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 06:00:15PM -0700, Todd Poynor wrote:
> Generate synchronous hotplug events for system suspend and resume
> events, via the power subsystem.  Recent discussions have indicated
> various methods for notification of these events are in use today; this
> is an attempt to move these into the generic power subsystem.  The patch
> relies on the "synchronous hotplug events via kobject" patch sent
> previously.

I still do not see the need for this.  As a user, you caused the
suspend/resume event to happen, why get notified of it again?  :)

Or am I missing something basic here?

thanks,

greg k-h
