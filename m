Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135625AbRDXN4j>; Tue, 24 Apr 2001 09:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135616AbRDXNz2>; Tue, 24 Apr 2001 09:55:28 -0400
Received: from [216.6.80.34] ([216.6.80.34]:11526 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S135628AbRDXNyt>; Tue, 24 Apr 2001 09:54:49 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A018D3127@dcmtechdom.dcmtech.co.in>
From: Rajeev Nigam <rajeev.nigam@dcmtech.co.in>
To: Hubertus Franke <frankeh@us.ibm.com>, alad@hss.hns.com
Cc: ofer@shunra.co.il, linux-kernel@vger.kernel.org
Subject: RE: Delay Function
Date: Tue, 24 Apr 2001 19:28:35 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is udelay(usecs) function which has told by Ofer Fryman one of the
member of mailing list, not delay(usecs) and its working properly.

Thanx to u all for ur cooperation.

Regards,
Rajeev

-----Original Message-----
From: Hubertus Franke [mailto:frankeh@us.ibm.com]
Sent: Tuesday, April 24, 2001 7:04 PM
To: alad@hss.hns.com
Cc: Rajeev Nigam
Subject: Re: Delay Function



you might want to use delay(usecs)..

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



alad@hss.hns.com@vger.kernel.org on 04/24/2001 04:58:19 AM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   Rajeev Nigam <rajeev.nigam@dcmtech.co.in>
cc:   linux-kernel@vger.kernel.org
Subject:  Re: Delay Function





It may be possible that this is not the good choice...
but u can try ... schedule_timeout(timeout) function.... see kernel/sched.c
for
more details about this function

Amol





Rajeev Nigam <rajeev.nigam@dcmtech.co.in> on 04/24/2001 03:29:04 PM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Amol Lad/HSS)

Subject:  Delay Function




What function i have to use to put a delay in a driver at kernel mode
between reading from and writing to com port.

Looking forward for ur help.

Thanx & Regards
Rajeev Nigam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


