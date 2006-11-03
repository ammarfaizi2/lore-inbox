Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753000AbWKCC67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbWKCC67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbWKCC67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:58:59 -0500
Received: from xenotime.net ([66.160.160.81]:63188 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752996AbWKCC66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:58:58 -0500
Date: Thu, 2 Nov 2006 18:58:54 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: David Brownell <david-b@pacbell.net>
cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       Randy Dunlap <randy.dunlap@oracle.com>, toralf.foerster@gmx.de,
       netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       link@miggy.org, akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
In-Reply-To: <200611021847.21817.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.58.0611021858140.16878@shark.he.net>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
 <200611021229.17324.david-b@pacbell.net> <20061103022726.GF13381@stusta.de>
 <200611021847.21817.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, David Brownell wrote:

> On Thursday 02 November 2006 6:27 pm, Adrian Bunk wrote:
>
> > It seems to lack the "select MII" at the USB_RTL8150 option that was in
> > Randy's first patch?
>
> I was just addressing the usbnet issues ... that driver doesn't
> use the usbnet framework.

and Randy is away for a few days with very limited net access.

-- 
~Randy
