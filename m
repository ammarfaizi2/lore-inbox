Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUDISN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUDISN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:13:28 -0400
Received: from linux-bt.org ([217.160.111.169]:39120 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261597AbUDISNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:13:25 -0400
Subject: Re: [PATCH] Add sysfs class support for CAPI
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Karsten Keil <kkeil@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ISDN Mailing List <isdn4linux@listserv.isdn4linux.de>
In-Reply-To: <20040409171612.GA15820@kroah.com>
References: <1081516925.13202.8.camel@pegasus>
	 <20040409171612.GA15820@kroah.com>
Content-Type: text/plain
Message-Id: <1081534391.26610.12.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Apr 2004 20:13:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > here is a patch that adds class support to the ISDN CAPI module. Without
> > it udev won't create the /dev/capi20 device node.
> 
> Looks good, but isn't there also a /dev/capi20.00 and so on device nodes
> needed by this driver?  According to devices.txt those are valid
> nodes...

according to devices.txt - yes. But I didn't found any references in the
source code nor any application using it. The /dev/capi20 device is a
multiplexing interface and the others must be somekind of relict. Maybe
Karsten knows the full story ;)

Regards

Marcel


