Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbQKVNfj>; Wed, 22 Nov 2000 08:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQKVNfa>; Wed, 22 Nov 2000 08:35:30 -0500
Received: from picard.csihq.com ([204.17.222.1]:41476 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S129682AbQKVNfV>;
	Wed, 22 Nov 2000 08:35:21 -0500
Message-ID: <096d01c05484$d0e9e6a0$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Fw: SMP proc/stat wrong?
Date: Wed, 22 Nov 2000 08:04:58 -0500
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


On my dual-SMP system:
cpu  15706258 0 4077925 308293017
cpu0 7877393 0 2034458 154126749
cpu1 7828865 0 2043467 154166268

On my other dual-SMP with only one CPU in it:
cpu  7364 0 5108 992193
cpu0 7364 0 5108 992193

On my non-SMP system:
cpu  16922 0 8096 968425
cpu0 16922 0 8096 968425

All three are running the exact same binary kernel 2.2.17.

So...why is the "nice" number always zero??

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
