Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131249AbRABSAJ>; Tue, 2 Jan 2001 13:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRABR77>; Tue, 2 Jan 2001 12:59:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65042 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131199AbRABR7u>; Tue, 2 Jan 2001 12:59:50 -0500
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Tue, 2 Jan 2001 17:31:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20010102173233.C1846@emma1.emma.line.org> from "Matthias Andree" at Jan 02, 2001 05:32:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DVHY-0002ZE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This had been a report for a non-portable computer which should (Duron)
> indeed have a TSC, that is, /proc/cpuinfo lists one ;-) Do 486s
> generally have APM so it might be worth fixing/working around for them?
> 
> If so, would re-reading from CMOS for boxes without TSC be a "valid"
> solution?

The TSC one is fairly sane, the CMOS gets messy because host and CMOS time
are not always the same

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
