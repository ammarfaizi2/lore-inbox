Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272312AbTHEAqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272316AbTHEAqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:46:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:52165 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272312AbTHEAqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:46:03 -0400
Date: Mon, 4 Aug 2003 17:45:52 -0700
From: Greg KH <greg@kroah.com>
To: David T Hollis <dhollis@davehollis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Mouse oddity with 2.6.0-test2-mm4 + 013int
Message-ID: <20030805004552.GA17205@kroah.com>
References: <3F2ED292.2040302@davehollis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2ED292.2040302@davehollis.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 05:39:30PM -0400, David T Hollis wrote:
> I just went to 2.6.0-test2-mm4 with Con's 012/013 interactivity patches 
> (from 2.6.0-test2-mm2) on my laptop and I'm now having an odd time with 
> my USB mouse.  After a short period of time (5 minutes or less), it 
> stops working entirely.  If I remove the usbmouse module and reload it, 
> I get it back.  There is nothing in my logs or dmesg output stating any 
> kind of problem.  Is anyone else seeing this problem?  Anyone happen to 
> know where the problem may lie?

Don't use the usbmouse module, use the hid module instead.

But that should not really cause this problem.  Can you enable
CONFIG_USB_DEBUG to see if anything else shows up in your logs?

Oh, and does this also happen with 2.6.0-test2?

thanks,

greg k-h
