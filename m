Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRDWXFg>; Mon, 23 Apr 2001 19:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDWXDr>; Mon, 23 Apr 2001 19:03:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2825 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132516AbRDWXDP>; Mon, 23 Apr 2001 19:03:15 -0400
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
To: Matt_Domsch@Dell.com
Date: Tue, 24 Apr 2001 00:04:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, dougg@torque.net, alan@lxorguk.ukuu.org.uk,
        jlundell@pobox.com
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E265@ausxmrr501.us.dell.com> from "Matt_Domsch@Dell.com" at Apr 23, 2001 05:06:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rpNy-0000jJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	The i2o controller can be on any bus type (though I expect most are
> PCI).  The i2o_controller struct has an i2o_hrt member, which does have bus

I've seen no non PCI one.

> information, but the PCI struct doesn't include subsystem vendor and device
> fields yet.  We'd need to add an IOCTL to retrieve this information,
> possibly one at a generic i2o level.   The EDD 3.0 spec shows that a PCI i2o

You can pull it from /proc if you know the bus info (which you can get by
querying via i2o_config.o)


