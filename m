Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTINKpw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 06:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTINKpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 06:45:52 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:43452 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262360AbTINKpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 06:45:51 -0400
Message-ID: <1f4b01c37aad$53675e40$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk@arm.linux.org.uk>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60> <20030914091702.B20889@flint.arm.linux.org.uk>
Subject: Re: 2.6.0-test5 vs. Ethernet cards
Date: Sun, 14 Sep 2003 19:45:14 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King" <rmk@arm.linux.org.uk> replied to me:

> > Shutting down PCMCIA unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > [...]
> > The only way to shut down at this point is to turn off the power.
>
> IIRC the problem is your hotplug scripts.  Maybe the hotplug folk can tell
> you the minimum version for 2.6.

Then I wonder why the interface came up automatically when the card was
inserted.  By the way the relevant module is pcnet_cs, which is 16-bit
PCMCIA.  I didn't guess that the hotplug scripts were used for that.  But
I'll try to find time to test it with new hotplug scripts some weekend.

(Can't do it now, I'm in the middle of installing SuSE 8.2 on that machine.)
