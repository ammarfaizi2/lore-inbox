Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbTF3VaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbTF3VaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:30:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49302 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265907AbTF3V25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:28:57 -0400
Date: Mon, 30 Jun 2003 14:43:19 -0700
From: Greg KH <greg@kroah.com>
To: martin f krafft <madduck@madduck.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: restarting a kernel thread
Message-ID: <20030630214319.GA27246@kroah.com>
References: <20030630194807.GD25566@piper.madduck.net> <20030630203941.GA26216@kroah.com> <20030630213604.GA3974@piper.madduck.net> <20030630194807.GD25566@piper.madduck.net> <20030630203941.GA26216@kroah.com> <20030630213957.GB3974@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630213604.GA3974@piper.madduck.net> <20030630213957.GB3974@piper.madduck.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 11:39:57PM +0200, martin f krafft wrote:
> also sprach Greg KH <greg@kroah.com> [2003.06.30.2239 +0200]:
> > Any reason for not sticking with userspace programs using
> > libusb/usbfs? Much easier to write than kernel drivers, and you
> > get portibility across a wider range of OSs
> 
> One question: will this have performance issues? We are dealing with
> high-resolution motors and sensors, and want to go real-time anyhow
> somewhen.

Don't know, you will have to test to see if it meets your latency
requirements.


On Mon, Jun 30, 2003 at 11:36:04PM +0200, martin f krafft wrote:
> 
> Well, that's a good idea. Problem is that the drivers are actually
> written by someone else. I just developing with them, and them
> a little on the side.
> 
> But I'll pass the word on to the developers. Is this an easy
> transition?

The interface is quite different from writing a kernel driver, but in
the end, simpler, as you can just debug from userspace and not worry
about kernel problems.

thanks,

greg k-h
