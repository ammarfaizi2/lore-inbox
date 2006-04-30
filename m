Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWD3Ekh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWD3Ekh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 00:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWD3Ekh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 00:40:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:7124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750920AbWD3Ekg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 00:40:36 -0400
Date: Sat, 29 Apr 2006 21:36:16 -0700
From: Greg KH <greg@kroah.com>
To: Otto Wyss <otto.wyss@orpatec.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-Keyboard through an USB-Switchbox
Message-ID: <20060430043616.GA13913@kroah.com>
References: <44526C3E.5080200@orpatec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44526C3E.5080200@orpatec.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 09:25:50PM +0200, Otto Wyss wrote:
> I'm using now again a second computer with a single USB keyboard through 
> an USB switchbox. Switching between computers is equivalent to connect 
> and disconnect the USB keyboard rather often. After this 
> disconnect/connect I still happen to experience times when the USB stack 
> can't synchronize again, leaving me without access to the computer 
> (kernel 2.6.12-9). I since I've mentioned this already several years ago 
> I though this might be solved but it seems Linux isn't able to build a 
> state-of-the-art USB stack which is able to synchronize in _each_ case.
> 
> Is there anything I can do to help find out why the USB doesn't work? Is 
> there a log anywhere on they system?

The kernel log can be seen by running 'dmesg'.  Also, try using a newer
kernel version, 2.6.12 is over a year old.

And, if 2.6.16 still has problems, please let the people at the
linux-usb-devel mailing list know about it.

thanks,

greg k-h
