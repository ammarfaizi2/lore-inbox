Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAXTiV>; Wed, 24 Jan 2001 14:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRAXTiM>; Wed, 24 Jan 2001 14:38:12 -0500
Received: from picard.csihq.com ([204.17.222.1]:14723 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S129737AbRAXTiD>;
	Wed, 24 Jan 2001 14:38:03 -0500
Message-ID: <06dc01c0863d$29383390$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Largefile support in 2.4
Date: Wed, 24 Jan 2001 14:38:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do normal users get to create/maintain large files (i.e. >2G) in Linux
2.4 on i386?

The root user can make filesize unlimited but a non-root user cannot.  They
come up with the same limits in both tcsh and bash (i.e. filesize
1048576 kbytes or 0x40000000)

I can't seem to find where this number comes from anywhere -- either in
glibc-2.2.1 or the kernel.   getrlimit64 returns it.

I can't make all my users root users!!!  Can anybody help?

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
