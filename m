Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLOShT>; Fri, 15 Dec 2000 13:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbQLOShJ>; Fri, 15 Dec 2000 13:37:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11529 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129228AbQLOSg7>; Fri, 15 Dec 2000 13:36:59 -0500
Subject: Re: test12 lockups -- need feedback
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 15 Dec 2000 18:06:58 +0000 (GMT)
Cc: ingo.oeser@informatik.tu-chemnitz.de, e.jokisch@u-code.de,
        linux-kernel@vger.kernel.org, davej@suse.de, hpa@zytor.com
In-Reply-To: <1368.195.67.189.102.976902742.squirrel@www.zytor.com> from "H. Peter Anvin" at Dec 15, 2000 09:52:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146zG2-0001bG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I also got a hard lockup (but with Oops) while calling the
> > "vendor CPU init" function during system boot.
> > 
> > This was on Cyrix III.
> > PS: CC'ed hpa, because he is cpu-detection maintainer and davej,
> >    because he added Cyrix III support and might know details ;-)
> 
> Please include the oops information, as well as the /proc/cpuinfo output.

Also be sure you built Pentium/TSC kernels as Cyrix III is a 686 core without
the cmov instruction it seems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
