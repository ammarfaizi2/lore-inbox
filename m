Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274809AbTGaQRB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274812AbTGaQRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:17:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:33997 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274809AbTGaQQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:16:57 -0400
Date: Thu, 31 Jul 2003 08:48:15 -0700
From: Greg KH <greg@kroah.com>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: USB problems encountered when offing Zaurus
Message-ID: <20030731154815.GB3202@kroah.com>
References: <20030731065200.GA1226@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731065200.GA1226@eugeneteo.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 02:52:00PM +0800, Eugene Teo wrote:
> I got this when I try to turn off Zaurus SL-5560.
> Any idea what went wrong?
> 
> I am using 2.6.0-test2-mm2-kj1. I am trying to turn
> off my Zaurus, and then turn it on again. When I turn
> it off, I get the following messages. When I turn it
> on, and try to do a samba mount, i get pretty unstable
> connection.pretty unstable
> connection.
> 
> Eugene
> 
> Jul 31 14:40:27 amaryllis kernel: uhci-hcd 0000:00:1d.0: remove, state 3
> Jul 31 14:40:27 amaryllis kernel: usb usb1: USB disconnect, address 1
> Jul 31 14:40:27 amaryllis kernel: Call Trace:
> Jul 31 14:40:27 amaryllis kernel:  [__might_sleep+95/114] __might_sleep+0x5f/0x72

Known bug, I have a fix for this in my tree which will get sent to Linus
in a few days.  The patch for this was posted to the linux-usb-devel
mailing list last week if it's really bothering you :)

thanks,

greg k-h
