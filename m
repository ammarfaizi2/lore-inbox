Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSJRFHX>; Fri, 18 Oct 2002 01:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSJRFHX>; Fri, 18 Oct 2002 01:07:23 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:5862 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262187AbSJRFHW>; Fri, 18 Oct 2002 01:07:22 -0400
Message-ID: <02e401c27664$eb00caa0$41368490@archaic>
From: "David McIlwraith" <quack@bigpond.net.au>
To: "omit_ECE" <omit@rice.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <004301c27664$9d224070$7e0c2a80@OMIT>
Subject: Re: Double & Integral don't match
Date: Fri, 18 Oct 2002 15:12:11 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3663.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3663.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No floating point in kernel.

- David McIlwraith
----- Original Message -----
From: "omit_ECE" <omit@rice.edu>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, October 18, 2002 3:10 PM
Subject: Double & Integral don't match


> Hi,
>
> In tcp_input.c, I declare a variable,
> double t_owd_;
> t_owd_ = rcv_tsecr - rcv_tsval;
>
> But in this case, the right side in the equation are integrals,
> which is against to the left side of double.
> I tried,
> t_owd_ = (double) rcv_tsecr - (double) rcv_tsval;
>
> It didn't work. How could I do to make it?
> Thank you.
>
> YuZen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

