Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUCCX20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUCCX20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:28:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:32899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261242AbUCCX2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:28:24 -0500
Date: Wed, 3 Mar 2004 15:06:04 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
Message-ID: <20040303230604.GA1038@kroah.com>
References: <10782873992219@kroah.com> <10782873993395@kroah.com> <20040303222454.A15007@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303222454.A15007@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 10:24:54PM +0000, Russell King wrote:
> On Tue, Mar 02, 2004 at 08:16:39PM -0800, Greg KH wrote:
> > ChangeSet 1.1612.24.4, 2004/03/02 16:39:36-08:00, greg@kroah.com
> > 
> > Driver core: add CONFIG_DEBUG_DRIVER to help track down driver core bugs easier.
> 
> Wouldn't a cleaner way to do this be to add -DDEBUG to EXTRA_CFLAGS
> in the makefile if CONFIG_DEBUG_DRIVER is set, and remove the #undef
> DEBUG statements in each .c file?

Yes it would, I didn't realize we could do that :)
Do any other subsystems do that?

thanks,

greg k-h
