Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTHTRI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTHTRI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:08:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:713 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262068AbTHTRIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:08:25 -0400
Date: Wed, 20 Aug 2003 10:08:18 -0700
From: Greg KH <greg@kroah.com>
To: John Bradford <john@grabjohn.com>
Cc: tmolina@cablespeed.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: Console on USB
Message-ID: <20030820170818.GA3468@kroah.com>
References: <200308201708.h7KH8jb8000739@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308201708.h7KH8jb8000739@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 06:08:45PM +0100, John Bradford wrote:
> > > Is there any advice I might be able to use to get this going?  I really 
> > > want to be able to catch some oops output.
> >
> > Buy a machine with a serial port.  That's my recommendation :)
> 
> That could be difficult in a few years time.  What are we going to do
> when we start getting bugs that are only reproducable on laptops with
> no legacy ports? 

Use the previously mentioned netconsole code.

Or use a firewire debug console, like some of the BSDs and Windows do
today.

Good luck,

greg k-h
