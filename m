Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265873AbTF3U0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbTF3U0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:26:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:48533 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265873AbTF3U0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:26:40 -0400
Date: Mon, 30 Jun 2003 13:39:41 -0700
From: Greg KH <greg@kroah.com>
To: martin f krafft <madduck@madduck.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: restarting a kernel thread
Message-ID: <20030630203941.GA26216@kroah.com>
References: <20030630171033.GA27703@diamond.madduck.net> <20030630180002.GA25461@kroah.com> <20030630194807.GD25566@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630194807.GD25566@piper.madduck.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 09:48:07PM +0200, martin f krafft wrote:
> > Oh, what kind of driver are you working on?
> 
> DC motor controllers, Servo motor controllers and A/D converters.
> galilmc.com is too expensive for my taste. i work on robots...

Any reason for not sticking with userspace programs using libusb/usbfs?
Much easier to write than kernel drivers, and you get portibility
across a wider range of OSs

thanks,

greg k-h
