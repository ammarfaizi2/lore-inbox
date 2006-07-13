Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWGMVhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWGMVhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWGMVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:37:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:59283 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030400AbWGMVhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:37:47 -0400
Date: Thu, 13 Jul 2006 14:04:20 -0700
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: devices.txt errors
Message-ID: <20060713210420.GA4218@kroah.com>
References: <787b0d920607082349h59ec36f7nc477e3cc9f9b6c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607082349h59ec36f7nc477e3cc9f9b6c77@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:49:19AM -0400, Albert Cahalan wrote:
> Major 216 was ttyUB%d (looks normal), but is now rfcomm%d instead?
> The description claims that the device is a tty, yet it no longer
> has a tty name?

Fun with bluetooth issues.  The ttyUB driver is now gone, and the bluez
code uses it instead.  Take it up with those developers if you have
questions...

thanks,

greg k-h
