Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131135AbQLMMkV>; Wed, 13 Dec 2000 07:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbQLMMkL>; Wed, 13 Dec 2000 07:40:11 -0500
Received: from net128-053.mclink.it ([195.110.128.53]:56039 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S131135AbQLMMjx>;
	Wed, 13 Dec 2000 07:39:53 -0500
From: "CMA" <cma@mclink.it>
To: "'Rainer Mager'" <rmager@vgkk.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: R: Signal 11 - the continuing saga
Date: Wed, 13 Dec 2000 13:10:10 +0100
Message-ID: <001501c064fd$a4997dc0$65000a0a@intracma.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGAEAHCJAA.rmager@vgkk.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> From: CMA [mailto:cma@mclink.it]
>> Did you already try to selectively disable L1 and L2 caches (if
>> your box has both) and see what happens?
>
>Anyone know how to do this?

If you own a p6 class machine (sorry but I didn't find your hw specs in
previous messages)
you should be able to enter setup and disable L1 and/or L2 usually in
"advanced setup".
If you disable L1, the machine will be *much* slower.
If you disable L2, you will notice it under heavy load.
Most of the times sig 11 is due L1 cache overheating (on chip). Just
controlling whether cpu cooling fan is properly seated and spinning solves
the problem.
Regards.
Dr. Eng. Mauro Tassinari
www.c-m-a.it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
