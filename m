Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130415AbQLZPxe>; Tue, 26 Dec 2000 10:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131039AbQLZPxX>; Tue, 26 Dec 2000 10:53:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18443 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130415AbQLZPxP>; Tue, 26 Dec 2000 10:53:15 -0500
Subject: Re: About Celeron processor memory barrier problem
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 25 Dec 2000 20:40:43 -0500 (EST)
Cc: timw@splhi.com (Tim Wright), kaih@khms.westfalen.de (Kai Henningsen),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012241410240.4404-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 24, 2000 02:25:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ag3l-0000MY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One thing we _could_ potentially do is to simplify the CPU selection a
> bit, and make it a two-stage process. Basically have a
> 
> 	bool "Optimize for current CPU" CONFIG_CPU_CURRENT
> 
> which most people who just want to get the best kernel would use. Less
> confusion that way.

If we do that I'd rather see a make autoconfig that does the lot from
proc/pci etc 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
