Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbULTIDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbULTIDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbULTICe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:02:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261487AbULTHQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:16:36 -0500
Date: Sun, 19 Dec 2004 23:06:03 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041219230603.7956d309@lembas.zaitcev.lan>
In-Reply-To: <200412192243.06324.david-b@pacbell.net>
References: <20041220001644.GI21288@stusta.de>
	<41C65EA0.7020805@osdl.org>
	<20041220062055.GA22120@one-eyed-alien.net>
	<200412192243.06324.david-b@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004 22:43:05 -0800, David Brownell <david-b@pacbell.net> wrote:

> It also seems to mean significantly slower access (at high speed)
> for the most standard devices.  That doesn't seem like a win,
> though I suspect fixing it should be as simple as switching over
> to use the USB scatterlist calls (which usb-storage uses) ...

They do not allow asynchronous operation, last time I checked.

-- Pete
