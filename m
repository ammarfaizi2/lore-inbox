Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129559AbQKGVHS>; Tue, 7 Nov 2000 16:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQKGVHI>; Tue, 7 Nov 2000 16:07:08 -0500
Received: from oe59.law4.hotmail.com ([216.33.148.155]:23049 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129363AbQKGVG4>;
	Tue, 7 Nov 2000 16:06:56 -0500
X-Originating-IP: [63.197.4.216]
From: "Lyle Coder" <x_coder@hotmail.com>
To: "Andre Hedrick" <andre@linux-ide.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Frank Davis" <fdavis112@juno.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E13t7dG-0007KT-00@the-village.bc.nu>
Subject: Re: Pentium 4 and 2.4/2.5
Date: Tue, 7 Nov 2000 13:06:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Message-ID: <OE59dY2pjID9Lv40q2H00001e2c@hotmail.com>
X-OriginalArrivalTime: 07 Nov 2000 21:06:49.0615 (UTC) FILETIME=[A52851F0:01C048FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
are you saying that rep;nop is not needed in the spinlocks? (because they
are for P4)

Thanks
Lyle
----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "Frank Davis" <fdavis112@juno.com>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 07, 2000 4:13 AM
Subject: Re: Pentium 4 and 2.4/2.5


> > Not to worry, some of us are working with the 'I' guys to do proper P4
> > detection.
>
> Be careful with the intel patches. The ones I've seen so far tried to call
the
> cpu 'if86' breaking several tools that do cpu model checking off uname.
They
> didnt fix the 2GHz CPU limit, they use 'rep nop' in the locks which is
> explicitly 'undefined behaviour' for non intel processors and they use the
> TSC without checking it had one.
>
> Hopefully they have improved since
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
