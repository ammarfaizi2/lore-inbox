Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbULTFPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbULTFPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 00:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULTFPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 00:15:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:10915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261421AbULTFPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 00:15:14 -0500
Message-ID: <41C65EA0.7020805@osdl.org>
Date: Sun, 19 Dec 2004 21:09:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       mdharm-usb@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
References: <20041220001644.GI21288@stusta.de>	<20041220003146.GB11358@kroah.com>	<20041220013542.GK21288@stusta.de> <20041219205104.5054a156@lembas.zaitcev.lan>
In-Reply-To: <20041219205104.5054a156@lembas.zaitcev.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Mon, 20 Dec 2004 02:35:42 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> 
> 
>>What about a dependency of BLK_DEV_UB on USB_STORAGE=n ?
> 
> 
> I have them both as 'm' in my configuration, works like a charm.

ub can work like that, but it makes it darned difficult to
use usb-storage like that.  ub wants to bind to the devices,
not usb-storage, and if ub is unloaded, usb-storage doesn't
bind to them.  at least that's been my experience with it.

-- 
~Randy
