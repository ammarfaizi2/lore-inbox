Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVKVXEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVKVXEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVKVXEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:04:46 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42444 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030227AbVKVXEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:04:44 -0500
Subject: Re: Christmas list for the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kasper Sandberg <lkml@metanurb.dk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <1132694935.10574.2.camel@localhost>
	 <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 23:36:53 +0000
Message-Id: <1132702614.20233.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 16:41 -0500, Jon Smirl wrote:
> An example of this is that the serial driver is hard coded to report
> four legacy serial ports when my system physically only has two. I
> have to change a #define and recompile the kernel to change this.

It does an autodetect sequence to find the ports. If it reports ttyS0-S3
your system probably has them, they may just not be wired to external
ports and that is kinda tricky to autodetect

> looks for everything again anyway. In a more friendly system X would
> use the info the kernel provides and automatically configure itself
> for the devices present or hotplugged. You could get rid of your
> xorg.cong file in this model.


Not really as half of xorg.conf is preferences

