Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUCDDd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUCDDd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:33:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:18080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261336AbUCDDdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:33:54 -0500
Date: Wed, 3 Mar 2004 19:33:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: andrea@suse.de, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040303193343.52226603.akpm@osdl.org>
In-Reply-To: <1078370073.3403.759.camel@abyss.local>
References: <20040228072926.GR8834@dualathlon.random>
	<Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	<20040229014357.GW8834@dualathlon.random>
	<1078370073.3403.759.camel@abyss.local>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev <peter@mysql.com> wrote:
>
> On Sat, 2004-02-28 at 17:43, Andrea Arcangeli wrote:
> 
> > > 
> > > Definately not what we expected, but a nice surprise nontheless.
> > 
> > this is the first time I hear something like this. Maybe you mean the
> > 4:4 was actually using more ram for the SGA? Just curious.
> 
> I actually recently Did MySQL benchmarks using DBT2 MySQL port.
> 
> The test box was  4Way Xeon w HT,  4Gb RAM,  8 SATA Disks in RAID10.
> 
> I used RH AS 3.0 for tests (2.4.21-9.ELxxx)
> 
> For Disk Bound workloads (200 Warehouse) I got 1250TPM for "hugemem" vs
> 1450TPM for "smp" kernel, which is some 14% slowdown.

Please define these terms.  What is the difference between "hugemem" and
"smp"?

> For CPU bound load (10 Warehouses) I got 7000TPM instead of 4500TPM,
> which is over 35% slowdown.

Well no, it is a 56% speedup.   Please clarify.  Lots.

