Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132474AbRAKWlh>; Thu, 11 Jan 2001 17:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132718AbRAKWlS>; Thu, 11 Jan 2001 17:41:18 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:39649 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S132474AbRAKWlN>; Thu, 11 Jan 2001 17:41:13 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Micah Gorrell" <angelcode@myrealbox.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Poll and Select not scaling
Date: Thu, 11 Jan 2001 14:41:12 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKCEKEMPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <000401c07b5c$08d924b0$9b2f4189@angelw2k>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have been trying to increase the scalabilty of an email server that has
> been ported to Linux.  It was originally written for Netware, and there we
> are able to provide over 30,000 connections at any given time.  On Linux
> however select stops working after the first 1024 connections.  I have
> changed include/linux/fs.h and updated NR_FILE to be 81920.  In test
> applications I have been able to create well over 30,000 connections but I
> am unable to do either a select or a poll on them.  Does any one
> know what I
> can do to fix this?

	Multithread.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
