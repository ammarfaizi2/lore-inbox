Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTGMENL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 00:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270098AbTGMENK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 00:13:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:17366 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270093AbTGMENH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 00:13:07 -0400
Date: Sat, 12 Jul 2003 21:24:22 -0700
From: Greg KH <greg@kroah.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75-mm1: lockup when inserting USB storage device
Message-ID: <20030713042422.GF2695@kroah.com>
References: <1058050082.4831.70.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058050082.4831.70.camel@ixodes.goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 03:48:02PM -0700, Jeremy Fitzhardinge wrote:
> Hi,
> 
> I'm getting a system lockup when I insert a USB storage device (either a
> IBM memory key, or a USB MemoryStick reader).
> 
> It seems to happen after I've done a suspend/resume cycle.  If I insert
> the device on a freshly booted system it doesn't lock up.

Most people get the suspend/resume cycle to work properly for USB by
unloading and then loading the host controller drivers.  Does that solve
this problem?

Yeah, I know it's not a perfect solution, sorry.  Hopefully we will get
better power management stuff soon...

thanks,

greg k-h
