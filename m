Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266142AbSKFVyw>; Wed, 6 Nov 2002 16:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266140AbSKFVyw>; Wed, 6 Nov 2002 16:54:52 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:53258 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S266142AbSKFVyu>; Wed, 6 Nov 2002 16:54:50 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB184B@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Robert Love'" <rml@tech9.net>, Manish Lachwani <manish@Zambeel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Regarding zerocopy implementation ...
Date: Wed, 6 Nov 2002 14:01:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the response. When you say zerocopy networking, do you refer to
zerocopy receives too? What linux kernel version offers this support? I am
making use of 2.4.17 ...

-----Original Message-----
From: Robert Love [mailto:rml@tech9.net]
Sent: Wednesday, November 06, 2002 1:46 PM
To: Manish Lachwani
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: Regarding zerocopy implementation ...


On Wed, 2002-11-06 at 10:23, Manish Lachwani wrote:
> Is there a zerocopy receive implementation in Linux? I know that FreeBSD
> 5.0-CURRENT has such an implementation named zerocopy sockets and when
used
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

