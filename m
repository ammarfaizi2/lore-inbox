Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129302AbRBBCTg>; Thu, 1 Feb 2001 21:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129481AbRBBCTP>; Thu, 1 Feb 2001 21:19:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7187 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129302AbRBBCTK>; Thu, 1 Feb 2001 21:19:10 -0500
Subject: Re: A buglet with LVM-0.9.1
To: jjs@toyota.com (J Sloan)
Date: Fri, 2 Feb 2001 02:20:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <3A7A1519.E140A726@toyota.com> from "J Sloan" at Feb 01, 2001 06:02:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OVpb-0005cL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I discovered that lvm seems to have a problem
> with compaq raid controllers - the partitions
> don't have the normal names like /dev/sda1,
> but instead names like /dev/ida/c0d0p1 -

Quite a few controllers do this i2o, ida, dac960, .. . The user tools really
need to cope with it. Its been true for a fair while and ended up necessary
before /dev/ simply got too big

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
