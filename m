Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVL2T7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVL2T7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVL2T7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:59:49 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3543 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750933AbVL2T7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:59:49 -0500
Subject: Re: EHCI TT bandwidth (was Re: [PATCH] USB_BANDWIDTH documentation
	change)
From: Lee Revell <rlrevell@joe-job.com>
To: ddstreet@ieee.org
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
References: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
	 <200512270857.35505.david-b@pacbell.net>
	 <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 15:05:39 -0500
Message-Id: <1135886739.6804.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 14:41 -0500, Dan Streetman wrote:
> On Tue, 27 Dec 2005, David Brownell wrote:
> 
> >(*) The issues folk have mentioned with bandwidth reservation for
> >    EHCI are more "full and low speed devcies can't use all the
> >    available transaction translator bandwidth" than anything else.
> 
> The patches I just sent to the linux-usb-devel list (couple days ago) take
> care of those scheduling restrictions...do you have any comments on them?  
> It would be great to get them in the kernel so EHCI can fully schedule any
> lowspeed or fullspeed buses that it manages.  I even put the changes 
> inside a kernel CONFIG option so people can test out the patches fully 
> before replacing the old model.
> 

How do I test them?  Should this make USB audio work with
CONFIG_USB_BANDWIDTH?

Lee

