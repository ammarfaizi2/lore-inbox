Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUBYIDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUBYIDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:03:18 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:27871 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S262345AbUBYIDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:03:15 -0500
Message-ID: <63068.68.151.39.198.1077696168.squirrel@www.harddata.com>
Date: Wed, 25 Feb 2004 01:02:48 -0700 (MST)
Subject: Re: Any recommended PATA or SATA chip for kernel 2.6.x ?
From: <mark@harddata.com>
To: <kylewong@southa.com>
In-Reply-To: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
References: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I need to build a six disk IDE md raid-5 with-in a month, Is here anyone
> and recommed some PATA or SATA chip which is known to be trouble free
> and kernel 2.6.x friendly?
>

3ware Escalade Raid controllers are your best bet. They are supported in
the default kernel and provide web and command line administration tools
for linux.

> I found in the market that most PCI IDE card are using "siimage (CMD?),
> HiPoint and IT8212 chip, are they working well with 2.6.x ?

Well when considering SATA last time I checked libata (library used by
open source SATA drivers) didn't support hotswapping. So really you can't
build a proper RAID 5 array without that. Some one can correct me if
Hotswap has now been added.

Some of the proprietary drivers may support hotswap, but I really don't
know. I know we played with the SIL3112a but never tried hotswap.


