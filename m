Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFMSuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFMSuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFMSrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:47:47 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:26813 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261194AbVFMSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:45:08 -0400
Message-ID: <001801c5704f$662fc0a0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Ian Campbell" <ijc@hellion.org.uk>
Cc: "Denis Vlasenko" <vda@ilport.com.ua>, <linux-kernel@vger.kernel.org>
References: <002301c57018$266079b0$2800000a@pc365dualp2> <200506131618.09718.vda@ilport.com.ua> <000a01c57035$79738a80$2800000a@pc365dualp2> <1118678551.23816.3.camel@icampbell-debian>
Subject: Re: [RFC] Observations on x86 process.c
Date: Mon, 13 Jun 2005 15:37:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm well aware of them Ian.  What I'm talking about is a somewhat different
broader notion that can be applied to things other than conditionals.

ex.

switch(whatever)
    {
    case blah:
        __attribute__((slowcode)) {
        /*
          An infrequently used, but plump block of code.
        */
        }

    case blahblah:
    ...etc...
    }


----- Original Message ----- 
From: "Ian Campbell" <ijc@hellion.org.uk>
To: <cutaway@bellsouth.net>
>
> I think you should probably checkout the likely() and unlikely() macros
> which are already defined for use in the kernel.
> Ian.

