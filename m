Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946025AbWBORGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946025AbWBORGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946026AbWBORGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:06:11 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:6274 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1946025AbWBORGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:06:10 -0500
Date: Wed, 15 Feb 2006 09:06:14 -0800
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
Message-ID: <20060215170614.GD1546@kroah.com>
References: <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.44L0.0602151103160.4598-100000@iolanthe.rowland.org> <20060215162720.GA1503@kroah.com> <1140021308.4117.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140021308.4117.45.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 05:35:08PM +0100, Arjan van de Ven wrote:
> On Wed, 2006-02-15 at 08:27 -0800, Greg KH wrote:
> > 
> > Nah, I don't think it's a good idea.  James's patch should work just
> > fine.
> 
> another option is to have a "kill list" which you put the thing on, and
> then wake up a thread. only 2 pointers in the object ;(

Hm, that's almost what James's patch is trying to do.  Care to mock up a
patch that shows this?  It might be a simpler solution.

thanks,

greg k-h
