Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVBCPj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVBCPj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbVBCPfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:35:13 -0500
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:46816 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S263207AbVBCPeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:34:44 -0500
Message-ID: <013401c50a05$dfa1bc00$8d00150a@dreammac>
From: "Pankaj Agarwal" <pankaj@toughguy.net>
To: "Tim Schmielau" <tim@physik3.uni-rostock.de>
Cc: <linux-kernel@vger.kernel.org>, "Linux Net" <linux-net@vger.kernel.org>
References: <001501c509ff$d4be02e0$8d00150a@dreammac> <Pine.LNX.4.53.0502031630290.4228@gockel.physik3.uni-rostock.de>
Subject: Re: Query - Regarding strange behaviour.
Date: Thu, 3 Feb 2005 21:04:29 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-PopBeforeSMTPSenders: pankaj@pnpexports.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - toughguy.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this isn't the case as i am able to create, edit and delete files in other 
directories under /usr.

----- Original Message ----- 
From: "Tim Schmielau" <tim@physik3.uni-rostock.de>
To: "Pankaj Agarwal" <pankaj@toughguy.net>
Cc: <linux-kernel@vger.kernel.org>; "Linux Net" <linux-net@vger.kernel.org>
Sent: Thursday, February 03, 2005 9:01 PM
Subject: Re: Query - Regarding strange behaviour.


> On Thu, 3 Feb 2005, Pankaj Agarwal wrote:
>
>> In my system there's a strange behaviour.... its not allowing me to 
>> create
>> any file in /usr/bin even as root. Its chmod is set to 755. Its even not
>> allowing me to change the chmod value of /usr/bin. The strangest part 
>> which
>> i felt is ...its shows the owner and group as root when i issue command
>> "ls -ld /usr/bin" and not allowing root to create any file or directory
>> under /usr/bin and not even allowing to change the chmod value. The error 
>> is
>> access permission denied... I can change the chmod value of /usr and 
>> other
>> directories under /usr/...but not of bin....
>
> Maybe /usr is mounted read-only? 

