Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVAHPhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVAHPhv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVAHPhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:37:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:8335 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261189AbVAHPhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:37:41 -0500
Date: Sat, 8 Jan 2005 07:37:37 -0800
From: Greg KH <greg@kroah.com>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Jonas Munsin <jmunsin@iki.fi>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] I2C patches for 2.6.10
Message-ID: <20050108153737.GA1454@kroah.com>
References: <11051627762989@kroah.com> <11051627762271@kroah.com> <20050108062251.GA5006@jupiter.solarsys.private> <20050108111528.177dc794.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108111528.177dc794.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 11:15:28AM +0100, Jean Delvare wrote:
> Hi Mark,
> 
> > * Greg KH <greg@kroah.com> [2005-01-07 21:39:36 -0800]:
> > > ChangeSet 1.1938.445.11, 2004/12/21 11:09:49-08:00, jmunsin@iki.fi
> > > 
> > > [PATCH] I2C: it87.c update
> > > 
> > >  - adds manual PWM
> > >  - removes buggy "reset" module parameter
> > >  - fixes some whitespaces
> > > 
> > > Signed-off-by: Jonas Munsin <jmunsin@iki.fi>
> > > Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> > 
> > You might hold off on this one patch... see this:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110514540928517&w=3
> 
> I second Mark on that. Please do not merge this one until Jonas and I
> have analyzed the problem and found an acceptable solution. Stopping
> fans on module load isn't exactly a good driver behavior :(

Ok, I've reverted this in the bk tree.

thanks,

greg k-h
