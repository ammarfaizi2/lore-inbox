Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268789AbTGOQBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268761AbTGOP6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:58:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:62105 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268748AbTGOP5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:57:48 -0400
Date: Tue, 15 Jul 2003 09:11:27 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030715161127.GA2925@kroah.com>
References: <20030715090726.GJ363@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715090726.GJ363@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 07:07:27PM +1000, CaT wrote:
> Ok. For a while i2c+sensors for me would freeze my box. Lately though
> it has been slowing it down to a crawl. And by slow I mean I can see
> the framebuffer console scroll block by block and be able to see 
> individual lines half-scrolled and suchlike things. All is fine with 
> the kernel until it hits the i2c and sensors code. Then it slows to
> a crawl. By the look at the HD usage indicator it seems that it pauses
> a second at a time (ie approx seconds pause, burst of activity, seconds
> pause etc). This also happened before AS was merged into the kernel.

So, if you don't have any i2c code loaded, everything works?  How about
just loading the i2c driver and not the sensor driver?

Oh, how about enabiling debugging in the i2c driver that you are using?
Any interesting info in the kernel log would be appreciated.

thanks,

greg k-h
