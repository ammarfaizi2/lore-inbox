Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVCSHMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVCSHMo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 02:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVCSHMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 02:12:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:1456 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262424AbVCSHMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 02:12:42 -0500
Date: Fri, 18 Mar 2005 23:01:28 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Locking changes to the driver-model core
Message-ID: <20050319070128.GC22579@kroah.com>
References: <Pine.LNX.4.44L0.0503161422440.639-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0503161422440.639-100000@ida.rowland.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 03:58:30PM -0500, Alan Stern wrote:
> Greg KH has said that he would like to remove the bus subsystem rwsem from 
> the driver model.  Here's a proposal for a way to accomplish that.  The 
> proposal is incomplete and requires changing the driver-model API a 
> little; I'd like to hear people's reactions and get suggestions on ways to 
> improve it.  (There's no patch with example code because it wouldn't be 
> functional yet.)

<nice proposal snipped>

It all sounds good, and I think that Pat has some code that implements
almost all of this already (I've seen some rough versions from him
recently.)  Hopefully he'll get that all cleaned up and send it out for
people to beat up on soon (hint...)

thanks,

greg k-h
