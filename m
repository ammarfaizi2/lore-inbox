Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHNQYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHNQYT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUHNQYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:24:19 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15323 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263775AbUHNQYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:24:16 -0400
Subject: Re: Linux SATA RAID FAQ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Willy Tarreau <willy@w.ods.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
In-Reply-To: <411D5D70.9070909@clanhk.org>
References: <411B0F45.8070500@pobox.com>
	 <20040812113413.GA19252@alpha.home.local>  <411D5D70.9070909@clanhk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092496912.27156.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 Aug 2004 16:21:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-14 at 01:31, J. Ryan Earl wrote:
> On the brightside, md raid5 is often faster than hardware raid5.  At 
> least on the 7000 and 8000 series of 3ware hardware; the 9000 series 
> looks promising though.  I haven't seen megaraid SATA numbers, and I 
> don't know what happened to the SX8.

Be cautious what you measure. One of he problems until you reach PCI-X
is PCI bandwidth. Thus software md5 can look good but the moment its
combined with other PCI activity goes down the pan entirely.

> When the libata Marvell drivers come out, you'll have a cheap upgrade 
> path for PCI-X boards if you want fast md raid: 

Agreed. PCI-X will change a lot of this for boxes that are not very
cpu/memory limited.
