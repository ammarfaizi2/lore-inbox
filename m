Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBURF2>; Wed, 21 Feb 2001 12:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbRBURFS>; Wed, 21 Feb 2001 12:05:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46741 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129184AbRBURFJ>;
	Wed, 21 Feb 2001 12:05:09 -0500
Importance: Normal
Subject: Re: Detecting SMP
To: Burton Windle <burton@fint.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFC8802461.DBFFD413-ON882569FA.005CEAE5@LocalDomain>
From: "Jay D Allen" <jaydallen@us.ibm.com>
Date: Wed, 21 Feb 2001 09:05:31 -0800
X-MIMETrack: Serialize by Router on D03NM075/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 02/21/2001 10:05:06 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



What is the platform ( x86, Sparc, alpha or ?)?  On sparc look in the
bootprom (ls /proc/openprom) that works regardless of kernel SMP status.
On Intel I think your out of luck, at least with the commonly available
hardware/software.  In theory there could be a bios-peeking structure in
/proc much like openprom that could give you hints...



Sent by:  linux-kernel-owner@vger.kernel.org

To:   linux-kernel@vger.kernel.org
cc:
Subject:  Detecting SMP



Hello. Is there a way, when running a non-SMP kernel, to detect or
otherwise tell (software only; the machine is 2400 miles away) if the
system has SMP capibilties? Would /proc/cpuinfo show two CPUs if the
kernel is non-SMP?  Thanks!

(btw, the kernel in question is a stock RH6.2 kernel 2.2.14-5, and yes, I
know I should update it anyways and that a SMP kernel will run on a UP
system)

--
Burton Windle                 burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.0/init/main.c:655

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



