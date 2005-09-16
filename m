Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVIPVDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVIPVDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVIPVDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:03:51 -0400
Received: from imap.gmx.net ([213.165.64.20]:404 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751285AbVIPVDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:03:49 -0400
X-Authenticated: #20450766
Date: Fri, 16 Sep 2005 22:11:47 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Wim Vinckier <wimpunk@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Trouble hotplugging on embedded system
In-Reply-To: <5c43128e050916024110467f02@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0509162210100.12505@poirot.grange>
References: <5c43128e050916024110467f02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Wim Vinckier wrote:

> I'm trying to get usb hotplugging working on a embedded system but it
> doesn't (seem to) work.  As far as i understand all the documents I've
> read, /sbin/hotplug (depending on /proc/sys/kernel/hotplug) should be
> called whenever plugging in a device.  I guess I've forgot to enable
> something in my kernel configuration but I can't find what went wrong.
>  I've tried 2.6.8 and 2.6.12 with busybox 1.01.

I think, there are some modifications needed to the hotplug to work with 
busybox. Either in shell script syntax, or something else - can't say 
exactly. Try to google for "hotplug busybox". I think, there was even a 
special version of hotplug for busybox somewhere...

Thanks
Guennadi
---
Guennadi Liakhovetski
