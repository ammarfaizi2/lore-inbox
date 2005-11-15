Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVKOVru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVKOVru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVKOVru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:47:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:11665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751122AbVKOVrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:47:49 -0500
Date: Tue, 15 Nov 2005 13:32:29 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051115213229.GB11776@kroah.com>
References: <20051115212942.GA9828@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115212942.GA9828@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:29:42PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is prototype of userland swsusp. I'd like kernel parts to go in,
> probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
> slightly ugly, OTOH it would be probably overkill to introduce
> syscalls just for this. (I'll need to add an ioctl for freeing memory
> in future).

What's wrong with 4 new syscalls?  It seems the cleanest way.

thanks,

greg k-h
