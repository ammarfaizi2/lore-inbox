Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130541AbQLOL7c>; Fri, 15 Dec 2000 06:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbQLOL7M>; Fri, 15 Dec 2000 06:59:12 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:36619 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S129325AbQLOL7K>;
	Fri, 15 Dec 2000 06:59:10 -0500
Date: Fri, 15 Dec 2000 03:28:41 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: question about tulip patch to set CSR0 for pci 2.0 bus
Message-ID: <Pine.SUN.3.96.1001215032427.22314A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SIS 85C496 on Asus sp3 appears to have an equivalent bug (same CSR0
setting fixes kernel deadlocks that occur when using the
non-burst-challenged 0x01A08000 setting), so if you're going to catch it
with a special case in the pci code, you need to catch that as well as the
Saturn II chipset.

Note: the pci probe (cat /proc/pci) on this machine says "No bursts" for
the host bridge.

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
