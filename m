Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRACWC2>; Wed, 3 Jan 2001 17:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRACWCS>; Wed, 3 Jan 2001 17:02:18 -0500
Received: from p3EE3CA16.dip.t-dialin.net ([62.227.202.22]:8455 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129771AbRACWCJ>; Wed, 3 Jan 2001 17:02:09 -0500
Date: Wed, 3 Jan 2001 23:02:04 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20010103230204.C15394@emma1.emma.line.org>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010102173233.C1846@emma1.emma.line.org> <E14DVHY-0002ZE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14DVHY-0002ZE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 02, 2001 at 17:31:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jan 2001, Alan Cox wrote:

> The TSC one is fairly sane, the CMOS gets messy because host and CMOS time
> are not always the same

The idea is to read out the CMOS clock before and after polling the
BIOS, hoping that the BIOS would not tamper with the CMOS time. However,
thinking more elaborately, I think, CMOS is limited to 1 s, so the
granularity will make the whole thing pretty vain.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
