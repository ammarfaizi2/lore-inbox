Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTIBVW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTIBVW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:22:56 -0400
Received: from quattro.sventech.com ([205.252.248.110]:43913 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id S261291AbTIBVWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:22:47 -0400
Date: Tue, 2 Sep 2003 17:22:41 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: Duncan Sands <baldrick@wanadoo.fr>, Fredrik Noring <noring@nocrew.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4: uhci-hcd.c: "host controller process error", slab call trace
Message-ID: <20030902172241.I27297@sventech.com>
References: <1062281812.3378.50.camel@h9n1fls20o980.bredband.comhem.se> <200308310136.02093.baldrick@wanadoo.fr> <20030902211947.GB19772@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902211947.GB19772@kroah.com>; from greg@kroah.com on Tue, Sep 02, 2003 at 02:19:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003, Greg KH <greg@kroah.com> wrote:
> On Sun, Aug 31, 2003 at 01:36:01AM +0200, Duncan Sands wrote:
> > Does the attached patch help?
> 
> Ugh, I've been running a bunch of usb stress tests today and kept having
> the uhci driver halt with this error.
> 
> After this patch, it all works with no problems that I can detect
> (ripping a cd image at the same time as syncing a visor and running a
> loop-back test on a usb-serial device and using the mouse and keyboard
> to type.)
> 
> > Alan, Johannes, did you have any further thoughts on this problem?
> > I'm still not sure what the best approach is.
> 
> So, Johannes, unless you violently disagree, I'm going to apply this
> patch and send it upwards as it does solve the problem for at least 2
> people here :)

No violent objections here :)

Thanks Duncan.

JE

