Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131235AbRAKXIw>; Thu, 11 Jan 2001 18:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132195AbRAKXIn>; Thu, 11 Jan 2001 18:08:43 -0500
Received: from mail.myrealbox.com ([192.108.102.201]:47192 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S132138AbRAKXIZ>;
	Thu, 11 Jan 2001 18:08:25 -0500
Message-ID: <003501c07c23$4ff9bb80$9b2f4189@angelw2k>
From: "Micah Gorrell" <angelcode@myrealbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Poll and Select not scaling
Date: Thu, 11 Jan 2001 16:07:47 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would just like to thank every one for your help.  I have found the
problem and it is now working wonderfuly.

Micah

-----Original Message-----
From: "David Schwartz" <davids@webmaster.com>
To: "Micah Gorrell" <angelcode@myrealbox.com>;
<linux-kernel@vger.kernel.org>
Date: Thursday, January 11, 2001 3:42 PM
Subject: RE: Poll and Select not scaling


>
>> I have been trying to increase the scalabilty of an email server that has
>> been ported to Linux.  It was originally written for Netware, and there
we
>> are able to provide over 30,000 connections at any given time.  On Linux
>> however select stops working after the first 1024 connections.  I have
>> changed include/linux/fs.h and updated NR_FILE to be 81920.  In test
>> applications I have been able to create well over 30,000 connections but
I
>> am unable to do either a select or a poll on them.  Does any one
>> know what I
>> can do to fix this?
>
> Multithread.
>
> DS
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
