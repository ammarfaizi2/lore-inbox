Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVBBXgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVBBXgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVBBXf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:35:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:18129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262825AbVBBXfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:35:19 -0500
Date: Wed, 2 Feb 2005 15:35:00 -0800
From: Greg KH <greg@kroah.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Bill Davidsen <davidsen@tmr.com>, Jirka Kosina <jikos@jikos.cz>,
       Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bad locking in drivers/base/driver.c
Message-ID: <20050202233500.GA14696@kroah.com>
References: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz> <20050125055651.GA1987@kroah.com> <41F5F623.5090903@sun.com> <41F64E87.8040501@tmr.com> <41F66F86.4000609@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F66F86.4000609@sun.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:10:46AM -0500, Mike Waychison wrote:

> Get rid of semaphore abuse by converting device_driver->unload_sem
> semaphore to device_driver->unloaded completion.
> 
> This should get rid of any confusion as well as save a few bytes in the
> process.
> 
> Signed-off-by: Mike Waychison <michael.waychison@sun.com>

Thanks, I've applied this to my trees, and it will show up in the next
-mm releases.

greg k-h
