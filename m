Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbTIBVT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTIBVT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:19:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:5249 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261268AbTIBVT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:19:56 -0400
Date: Tue, 2 Sep 2003 14:19:48 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Fredrik Noring <noring@nocrew.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4: uhci-hcd.c: "host controller process error", slab call trace
Message-ID: <20030902211947.GB19772@kroah.com>
References: <1062281812.3378.50.camel@h9n1fls20o980.bredband.comhem.se> <200308310136.02093.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308310136.02093.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 01:36:01AM +0200, Duncan Sands wrote:
> Does the attached patch help?

Ugh, I've been running a bunch of usb stress tests today and kept having
the uhci driver halt with this error.

After this patch, it all works with no problems that I can detect
(ripping a cd image at the same time as syncing a visor and running a
loop-back test on a usb-serial device and using the mouse and keyboard
to type.)

> Alan, Johannes, did you have any further thoughts on this problem?
> I'm still not sure what the best approach is.

So, Johannes, unless you violently disagree, I'm going to apply this
patch and send it upwards as it does solve the problem for at least 2
people here :)

thanks,

greg k-h
