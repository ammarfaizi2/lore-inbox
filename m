Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbTF0Wjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTF0Wjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:39:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41149 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264906AbTF0Wjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:39:44 -0400
Date: Fri, 27 Jun 2003 14:22:40 -0700
From: Greg KH <greg@kroah.com>
To: Andreas Tscharner <starfire@dplanet.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]Kernel 2.4.21: EHCI does not repeat keys
Message-ID: <20030627212240.GB10176@kroah.com>
References: <20030627192959.7a903cab.starfire@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627192959.7a903cab.starfire@dplanet.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 07:29:59PM +0200, Andreas Tscharner wrote:
> Hello World,
> 
> My PS/2 keyboard is connected to my ladptop via a PS/2 to USB converter
> (My laptop has no PS/2 port and there is no USB variant of my keyboard).
> I have USB2.0, so I tried the EHCI. Unfortunately, the keys are not
> repeated when I keep my finger on a key. This works perfectly with the
> UHCI module.

EHCI in 2.4.21 is quite "unstable".  Try the big 2.4.21 USB patch I
posted to linux-kernel right after 2.4.21 came out to possibly fix this.

Hope this helps,

greg k-h
