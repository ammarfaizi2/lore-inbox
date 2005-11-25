Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVKYD2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVKYD2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 22:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVKYD2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 22:28:42 -0500
Received: from fmr20.intel.com ([134.134.136.19]:43446 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751178AbVKYD2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 22:28:41 -0500
Subject: Re: ipw2200 in 2.6.15-rc2-git4 warns about improper NETDEV_TX_BUSY
	retcode
From: Zhu Yi <yi.zhu@intel.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
References: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
Content-Type: text/plain
Organization: Intel Corp.
Date: Fri, 25 Nov 2005 11:23:32 +0800
Message-Id: <1132889013.24413.5.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 00:38 +0100, Alessandro Suardi wrote:
> Dell Latitude D610, FC4 base distro, kernel is:
> 
> [asuardi@sandman ~]$ cat /proc/version
> Linux version 2.6.15-rc2-git4 (asuardi@sandman) (gcc version 4.0.1
> 20050727 (Red Hat 4.0.1-5)) #2 Fri Nov 25 00:15:46 CET 2005
> 
> Onboard wireless card as detected by kernel is:
> ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
> 
>  and I placed the 2.4 firmware from sourceforge.net in /lib/firmware.
> 
> ifup eth1 yields this message:
> 
> eth1: NETDEV_TX_BUSY returned; driver should report queue full via
> ieee_device->is_queue_full.

Please use the patch here. It will be push to upstream very soon.
http://bughost.org/bugzilla/show_bug.cgi?id=808

Thanks,
-yi

