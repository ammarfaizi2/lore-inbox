Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWECF3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWECF3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 01:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWECF3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 01:29:51 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:19539 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965096AbWECF3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 01:29:50 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Date: Tue, 2 May 2006 22:29:47 -0700
User-Agent: KMail/1.7.1
Cc: Michael Helmling <supermihi@web.de>, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <200605021509.17050.david-b@pacbell.net> <200605030706.56908.supermihi@web.de>
In-Reply-To: <200605030706.56908.supermihi@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022229.47937.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 10:06 pm, Michael Helmling wrote:

> > Was it you who removed the copyrights from the "usbnet" driver and
> > changed the author assertion to one "M Subrahmanya Srihdar" ??
> > I'm guessing the latter; the www.moschip.com site implies that
> > its engineering HW is in India.
> 
> No, I did not change the code in any way, it is exactly the version they 
> mailed me.

That's what I strongly suspected.


> But I don't really understand what you are saying about the usbnet  
> module. They gave me the sourcecode for a yet not available kernel module 
> "mcs7830", not usbnet. Or did they just modify usbnet? I don't know enough 
> about such things to distinguish from both. 

They just hacked "usbnet".  There are huge chunks of code, and comments,
that are clearly identical.  At least half of the "moschip" driver.


> > Either way, blatant plagiarism and theft of copyright is unlikely
> > to get into upstream kernels.
> 
> I personally have the feeling that they didn't do this by purpose. They were 
> very willing to help me with the driver and don't seem to understand much of 
> kernel development. Anyway, if this IS a copyright violation, they should 
> really change it quickly.

"M Subrahmanya Srihdar" didn't "accidentally" copy the bulk of usbnet, remove all
the attributions, and replace them ... not possible.  There were certainly a few
chip-specific additions of course, right where "usbnet" expects them, but the
core driver is obviously all "usbnet" code.

- Dave

