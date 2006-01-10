Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWAJMZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWAJMZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWAJMZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:25:04 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:32268 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1750719AbWAJMZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:25:03 -0500
Date: Tue, 10 Jan 2006 23:25:31 +1100
From: CaT <cat@zip.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15: usb storage device not detected
Message-ID: <20060110122531.GE2035@zip.com.au>
References: <20060109130540.GB2035@zip.com.au> <20060109101713.469d3a7f.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109101713.469d3a7f.zaitcev@redhat.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 10:17:13AM -0800, Pete Zaitcev wrote:
> On Tue, 10 Jan 2006 00:05:50 +1100, CaT <cat@zip.com.au> wrote:
> 
> > kernel: [  111.330762] usb 1-5: new high speed USB device using ehci_hcd and address 3
> > kernel: [  112.180267] ub(1.3): Stall at GetMaxLUN, using 1 LUN
> > kernel: [  151.843141] usb 1-5: USB disconnect, address 3
> 
> This is very unusual. The quickest workaround is to unset CONFIG_BLK_DEV_UB,
> like Alan said. But it is very curious how this could happen. Care to

Well I'll leave it in there if it'll help find the bug. :)

> collect a usbmon trace for me? There's a howto in
> Documentation/usb/usbmon.txt

Will do probably in a few days. Have to be not tired enough when I get
hom to remember to do it. :)

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
