Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVGZVPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVGZVPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVGZVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:13:36 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:33199 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S262087AbVGZVLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:11:16 -0400
Message-ID: <42E6A6E7.5000402@pantasys.com>
Date: Tue, 26 Jul 2005 14:11:03 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ACPI] Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (2/2)
References: <200507261247.05684.rjw@sisk.pl> <200507261254.05507.rjw@sisk.pl> <42E62BB0.6010409@gmx.net> <200507262302.37488.rjw@sisk.pl>
In-Reply-To: <200507262302.37488.rjw@sisk.pl>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jul 2005 21:11:44.0765 (UTC) FILETIME=[A06A22D0:01C59226]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday, 26 of July 2005 14:25, Carl-Daniel Hailfinger wrote:
>>The current in-kernel sk98lin driver is years behind the version
>>downloadable from Syskonnect. Maybe it would make sense to update
>>it first before applying any new patches.
>>http://www.syskonnect.com/support/driver/d0102_driver.html
> 
> 
> You are right, but I don't know who should do this.  I have only submitted
> the patch to eliminate a problem with the current kernel.

have a look at the skge driver, this is a cleaned up version of the 
sk98lin. Although it doesn't support all of the devices, ie ones based 
on the Yukon 2.

peter
