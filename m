Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVKMBpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVKMBpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVKMBpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:45:41 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:15083 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750798AbVKMBpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:45:41 -0500
From: larry.finger@att.net (Larry.Finger@lwfinger.net)
To: linux-kernel@vger.kernel.org (kernel)
Subject: Re: linux-2.6.15-rc1: ipw2200 still not working 
Date: Sun, 13 Nov 2005 01:45:39 +0000
Message-Id: <111320050145.2779.43769AC30008CFA600000ADB21603763169D0A09020700D2979D9D0E04@att.net>
X-Mailer: AT&T Message Center Version 1 (Oct 30 2005)
X-Authenticated-Sender: bGFycnkuZmluZ2VyQGF0dC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, okay, the ipw2200 works fine if I turn off all security on the AP,
>but the 2.6.15-rc1 version can no longer connect to my WPA/WPA2 network.
>
>The same driver version out-of-tree works fine on 2.6.13,
>but not on 2.6.14, nor in-tree with 2.6.15-rc1.
>
>The syslog shows:
>
>ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
>ipw2200: Copyright(c) 2003-2005 Intel Corporation
>...
>eth1: NETDEV_TX_BUSY returned; driver should report queue full via ieee_device->is_queue_full.
>...
>ipw2200: U ipw_best_network Network 'RTR (00:13:46:16:96:b8)' excluded because of privacy mismatch: off != on.

I don't know if it affects you, but I was not able to get WPA working on my Linksys WPC54G using ndiswrapper with the 2.6.14-xxx kernels until I downloaded, built and installed a new version of wpa_supplicant.

Larry
