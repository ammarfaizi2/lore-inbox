Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266138AbSKFVwz>; Wed, 6 Nov 2002 16:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbSKFVwz>; Wed, 6 Nov 2002 16:52:55 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3346
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266138AbSKFVwy>; Wed, 6 Nov 2002 16:52:54 -0500
Subject: Re: Regarding zerocopy implementation ...
From: Robert Love <rml@tech9.net>
To: Manish Lachwani <manish@Zambeel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB183D@xch-a.win.zambeel.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB183D@xch-a.win.zambeel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 16:46:24 -0500
Message-Id: <1036619185.3405.1407.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 10:23, Manish Lachwani wrote:
> Is there a zerocopy receive implementation in Linux? I know that FreeBSD
> 5.0-CURRENT has such an implementation named zerocopy sockets and when used
> with a Alteon Tigon II NIC with header splitting turned on in Firmware,
> works well. Do we have any such implementation in Linux? Any reponse is
> greatly appreciated ...

Yes, we have zero-copy networking if the device supports the requisite
features and the driver is so coded.

Quick glance over 2.4, it looks like the following drivers support
zero-copy networking: via-rhine, tg3, sunhme, sungem, starfire, ns83820,
dl2k, acenic, 8139too, 8139cp, 3c59x family (includes 3c9xx), Intel
e100, and Intel e1000.

	Robert Love


