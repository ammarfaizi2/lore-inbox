Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbTF1Tfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTF1Tfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:35:38 -0400
Received: from granite.he.net ([216.218.226.66]:30221 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265373AbTF1Tfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:35:33 -0400
Date: Sat, 28 Jun 2003 12:41:02 -0700
From: Greg KH <greg@kroah.com>
To: Dan Aloni <da-x@gmx.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [TRIVIAL] avoid Oops in net/core/dev.c
Message-ID: <20030628194102.GA2384@kroah.com>
References: <20030628083810.GA2793@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628083810.GA2793@callisto.yi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 11:38:10AM +0300, Dan Aloni wrote:
> 
> BTW2, the attempt to rename the device here doesn't affect
> sysfs. Patrick, we need a class_device_* interface that does 
> this.

That's a good idea (I'm the person to blame for the class_device code,
not Pat.)  Care to send a patch?

thanks,

greg k-h
