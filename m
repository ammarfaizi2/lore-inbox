Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVAGRlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVAGRlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVAGRkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:40:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:52097 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261370AbVAGRiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:38:20 -0500
Date: Fri, 7 Jan 2005 09:38:21 -0800
From: Greg KH <greg@kroah.com>
To: Ikke <ikke.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobject_uevent
Message-ID: <20050107173821.GA15417@kroah.com>
References: <297f4e01050107065060e0b2ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297f4e01050107065060e0b2ad@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 03:50:52PM +0100, Ikke wrote:
> One of the new features of 2.6.10 (well, AFAIK its new) is the
> kobject_uevent function set.
> Currently only some places send out events like this, so I was
> thinking to add some more.
> 
> Question is: how can I test this? Is there any userland program that
> catches these events and prints some information on them to the
> screen?

http://www.us.kernel.org/pub/linux/utils/kernel/hotplug/uevent_listen.c
should be a good place to start.  It's what I used to verify stuff was
working properly.

Good luck,

greg k-h
