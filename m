Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTF1Qiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTF1Qiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 12:38:54 -0400
Received: from granite.he.net ([216.218.226.66]:30480 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265284AbTF1Qix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 12:38:53 -0400
Date: Sat, 28 Jun 2003 09:47:48 -0700
From: Greg KH <greg@kroah.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 USB oops
Message-ID: <20030628164748.GB1619@kroah.com>
References: <m2smpu73du.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2smpu73du.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 06:11:57AM -0700, Jan Rychter wrote:
> I got the following oops after doing "modprobe uhci". The system froze
> completely about 30 seconds after that.
> 
> Before that, I have unloaded uhci, loaded usb-uhci, and then unloaded
> usb-uhci again. This could be relevant.

So if you just load the uhci driver everything works?
Did you have any usb devices connected?

thanks,

greg k-h
