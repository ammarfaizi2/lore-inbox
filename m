Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUCDDPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCDDPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:15:39 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:37298 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261428AbUCDDPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:15:30 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Peter Zaitsev <peter@mysql.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040229014357.GW8834@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random>
	 <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	 <20040229014357.GW8834@dualathlon.random>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1078370073.3403.759.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 19:14:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 17:43, Andrea Arcangeli wrote:

> > 
> > Definately not what we expected, but a nice surprise nontheless.
> 
> this is the first time I hear something like this. Maybe you mean the
> 4:4 was actually using more ram for the SGA? Just curious.

I actually recently Did MySQL benchmarks using DBT2 MySQL port.

The test box was  4Way Xeon w HT,  4Gb RAM,  8 SATA Disks in RAID10.

I used RH AS 3.0 for tests (2.4.21-9.ELxxx)

For Disk Bound workloads (200 Warehouse) I got 1250TPM for "hugemem" vs
1450TPM for "smp" kernel, which is some 14% slowdown.

For CPU bound load (10 Warehouses) I got 7000TPM instead of 4500TPM,
which is over 35% slowdown.





-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

