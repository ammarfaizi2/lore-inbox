Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVL2TmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVL2TmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVL2TmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:42:03 -0500
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:52623 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750898AbVL2TmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:42:02 -0500
Date: Thu, 29 Dec 2005 14:41:56 -0500 (EST)
From: Dan Streetman <ddstreet@ieee.org>
Reply-To: ddstreet@ieee.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: EHCI TT bandwidth (was Re: [PATCH] USB_BANDWIDTH documentation
 change)
In-Reply-To: <200512270857.35505.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
References: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
 <200512270857.35505.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELNK-Trace: a4c357c9134943511aa676d7e74259b7b3291a7d08dfec79ce0894556603991693fbf654c251a500350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.148.162.106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2005, David Brownell wrote:

>(*) The issues folk have mentioned with bandwidth reservation for
>    EHCI are more "full and low speed devcies can't use all the
>    available transaction translator bandwidth" than anything else.

The patches I just sent to the linux-usb-devel list (couple days ago) take
care of those scheduling restrictions...do you have any comments on them?  
It would be great to get them in the kernel so EHCI can fully schedule any
lowspeed or fullspeed buses that it manages.  I even put the changes 
inside a kernel CONFIG option so people can test out the patches fully 
before replacing the old model.




-- 
Dan Streetman
ddstreet@ieee.org
---------------------
186,272 miles per second:
It isn't just a good idea, it's the law!
