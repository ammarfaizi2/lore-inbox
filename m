Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSKERvF>; Tue, 5 Nov 2002 12:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265106AbSKERvF>; Tue, 5 Nov 2002 12:51:05 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36757 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265102AbSKERuN>; Tue, 5 Nov 2002 12:50:13 -0500
Subject: Re: When laptop is docked, eth0 moves from pcmcia to docking
	station nic (both work wth same driver)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002601c284ef$395ef5d0$0472e50c@peecee>
References: <002601c284ef$395ef5d0$0472e50c@peecee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 18:18:57 +0000
Message-Id: <1036520337.4791.111.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 17:17, Buddy Lumpkin wrote:
> I have a laptop with a 3com PCMCIA NIC and a 3com NIC built into a
> docking station. When I dock my laptop, eth0 becomes the docking station
> NIC. I just want to know where to look to be able to control which
> device becomes which device. Im used to Solaris where a path_to_inst
> file correlates a device path to an instance number and device links are
> made accordingly. Does Linux have a similar capability?

You can ask for the MAC or PCI address of an interface, and you can
rename interfaces if you wish. The Red Hat 8.0 scripts are one example
that supports this

