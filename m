Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132504AbRAJMFv>; Wed, 10 Jan 2001 07:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135270AbRAJMFl>; Wed, 10 Jan 2001 07:05:41 -0500
Received: from picard.csihq.com ([204.17.222.1]:31500 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S132504AbRAJMFb>;
	Wed, 10 Jan 2001 07:05:31 -0500
Message-ID: <069d01c07afd$95143d20$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: 2.4.0,2.2.18 and epic100 broke
Date: Wed, 10 Jan 2001 07:05:11 -0500
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

FYI -- the epic100 SMC EtherPower II card does NOT work in SMP mode on 2.4.0
(or 2.2.18 either).

Donald Becker's most recent version hasn't been forward-ported to 2.4 and
the 2.2.17 drivers won't compile either.
The SMC card DOES work in non-SMP machines.  So...I'm putting in a 3com905
until this gets fixed.
Don said that locking was broken in the 1.1.5 release.

The last SMP kernel that ran with the SMC was 2.2.17 -- it's been broke
since (i.e. 2.2.18 does'nt work either -- that's where 1.1.5 was
introduced).

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
