Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265730AbSJYATJ>; Thu, 24 Oct 2002 20:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265734AbSJYATJ>; Thu, 24 Oct 2002 20:19:09 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:45140 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S265730AbSJYAS4>; Thu, 24 Oct 2002 20:18:56 -0400
Message-ID: <BD9B60A108C4D511AAA10002A50708F2073175F8@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'H. J. Lu'" <hjl@lucon.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: PCI device order problem
Date: Thu, 24 Oct 2002 17:25:01 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you're that concerned about possible ordering changes due to future BIOS
upgrades, I'd suggest setting up an /etc/mactab and using nameif to control
interface naming from userspace.

-- Chris Leech

> -----Original Message-----
> From: H. J. Lu [mailto:hjl@lucon.org] 
> We can use eth1. It is just very confusing since Linux and 
> hardware manual don't agree which one is the first NIC. Also, 
> when we upgrade the BIOS, the BIOS order may change. As for 
> other schemes, we don't want to change every software which 
> access ethX.
