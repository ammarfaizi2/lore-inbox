Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUA1NXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUA1NXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:23:21 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:40665 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S265939AbUA1NXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:23:20 -0500
From: Shmuel Hen <shmulik.hen@intel.com>
Organization: Intel Corporation
To: "Willy Tarreau" <willy@w.ods.org>, <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH-2.4] add missing '\n' in bonding messages
Date: Wed, 28 Jan 2004 15:23:00 +0200
User-Agent: KMail/1.5.3
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
References: <E791C176A6139242A988ABA8B3D9B38A03A9CCD3@hasmsx403.iil.intel.com>
In-Reply-To: <E791C176A6139242A988ABA8B3D9B38A03A9CCD3@hasmsx403.iil.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="tscii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401281523.00369.shmulik.hen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 January 2004 15:04, Willy Tarreau wrote:
>
> there are a few places where the bonding driver displays
> informational messages without the trailing '\n', which is
> sometimes annoying because messages get logged at the wrong level.
>
> Here's the patch against 2.4.25-pre7. I haven't checked 2.6 nor the
> bonding cleanup patch against those typos.
>

All those fixes are in the cleanup set and have been picked up by Jeff 
for both netdev-2.4 and netdev-2.6 BK trees. To the best of my 
understanding, they will be held until 2.4.25 and 2.6.2 are released.


-- 
| Shmulik Hen   Advanced Network Services  |
| Israel Design Center, Jerusalem          |
| LAN Access Division, Platform Networking |
| Intel Communications Group, Intel corp.  |

