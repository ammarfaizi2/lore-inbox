Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTIVTtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTIVTtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:49:25 -0400
Received: from 143.80-203-43.nextgentel.com ([80.203.43.143]:16873 "EHLO
	sort.fjase.net") by vger.kernel.org with ESMTP id S263336AbTIVTtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:49:23 -0400
Subject: RE: SiI3112: problemes with shared interrupt line?
From: Per Andreas Buer <perbu@linpro.no>
To: Allen Martin <AMartin@nvidia.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F6B3@mail-sc-6.nvidia.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F6B3@mail-sc-6.nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064260163.2414.3.camel@sort.fjase.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 22 Sep 2003 21:49:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-22 at 21:42, Allen Martin wrote:

> There are two issues I know about:
> 
> 1) Earlier versions of the Asus BIOS would program incorrect timing in the
> nForce internal P2P bridge, causing failures with SI3112 under high disk
> activity.  This is fixed in rev 1005 of their BIOS or later.

I am running the latest (1006, I think) ASUS (this is a ASUS A7
something Deluxe motherboard) BIOS revision.

> 2) PCI interrupts getting put into edge triggered mode when ACPI/APIC are
> enabled.  Andrew de Quincey said this should be fixed in 2.4.22, but I
> haven't tested it myself (I have ACPI disabled on all my test systems).  I
> did verify his patch on 2.6 when he first posted it, and it works.

I've tried disabeling APIC - it did not help.

I'll try 2.6.something tomorrow. 

-- 
There are only 10 different kinds of people in the world,
those who understand binary, and those who don't.

