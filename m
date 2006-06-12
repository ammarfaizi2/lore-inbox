Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWFLWF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWFLWF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWFLWF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:05:56 -0400
Received: from mail.suse.de ([195.135.220.2]:9407 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932560AbWFLWFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:05:55 -0400
Date: Mon, 12 Jun 2006 15:03:21 -0700
From: Greg KH <gregkh@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
Message-ID: <20060612220321.GA19792@suse.de>
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de> <448DE28D.3040708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448DE28D.3040708@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 05:54:21PM -0400, Mark Lord wrote:
> Okay, with these two patches from -mm, the USB no longer dies
> when I plug in my hub/dock device:
> 
> gregkh-usb-improved-tt-scheduling-for-ehci.patch
> gregkh-usb-usb-rmmod-pl2303-after-28.patch
> 
> So let's get these pushed upstream sooner than later, please!

It will happen after 2.6.17 is out, as they are in the queue to do so.

And it's not a "must rush" fix, this has _always_ been like this, you
just got lucky in the past :)

thanks,

greg k-h
