Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbRABRDd>; Tue, 2 Jan 2001 12:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbRABRDX>; Tue, 2 Jan 2001 12:03:23 -0500
Received: from p3EE3CA8B.dip.t-dialin.net ([62.227.202.139]:15108 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129736AbRABRDG>; Tue, 2 Jan 2001 12:03:06 -0500
Date: Tue, 2 Jan 2001 17:32:33 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20010102173233.C1846@emma1.emma.line.org>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001231113423.A5146@emma1.emma.line.org> <E14CifW-000818-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14CifW-000818-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Dec 31, 2000 at 13:37:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Alan Cox wrote:

> If you have a tsc on your chip - I think most modern laptops will do as they
> tend to be pentium/mmx k6 or pII/pIII processors, then you can check the 
> elapsed CPU cycles and recover the jiffies from that. Might be an interesting
> exercise for someone

This had been a report for a non-portable computer which should (Duron)
indeed have a TSC, that is, /proc/cpuinfo lists one ;-) Do 486s
generally have APM so it might be worth fixing/working around for them?

If so, would re-reading from CMOS for boxes without TSC be a "valid"
solution?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
