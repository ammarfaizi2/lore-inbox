Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRDMWQx>; Fri, 13 Apr 2001 18:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRDMWQh>; Fri, 13 Apr 2001 18:16:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132045AbRDMWQc>; Fri, 13 Apr 2001 18:16:32 -0400
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
To: dougg@torque.net (Douglas Gilbert)
Date: Fri, 13 Apr 2001 23:18:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Matt_Domsch@Dell.com (Matt Domsch)
In-Reply-To: <3AD778AE.F80C8956@torque.net> from "Douglas Gilbert" at Apr 13, 2001 06:07:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oBtM-0003fN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also ISA adapters are not the only non-PCI adapters,
> there are the growing band of pseudo adapters that
> may or may not have a PCI bus at the bottom of some
> other protocol stack.

An ioctl might be better. We already have an ioctl for querying the lun
information for a disk. We could also return the bus information for its
controller(s) [remember multipathing]

> 

