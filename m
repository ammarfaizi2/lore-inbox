Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbVBCQS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbVBCQS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVBCQS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:18:59 -0500
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:6890 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S263585AbVBCQSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:18:33 -0500
Message-ID: <019501c50a0b$fcf8a9c0$8d00150a@dreammac>
From: "Pankaj Agarwal" <pankaj@toughguy.net>
To: "S Iremonger" <exxsi@bath.ac.uk>
Cc: <linux-os@analogic.com>, <linux-kernel@vger.kernel.org>,
       "Linux Net" <linux-net@vger.kernel.org>
References: <001501c509ff$d4be02e0$8d00150a@dreammac> <Pine.LNX.4.61.0502031017430.9404@chaos.analogic.com> <015901c50a07$721f2620$8d00150a@dreammac> <Pine.GSO.4.53.0502031602400.21155@amos.bath.ac.uk>
Subject: Re: Query - Regarding strange behaviour.
Date: Thu, 3 Feb 2005 21:48:12 +0530
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

my fault...i'm able to copy it using -rf with CP. So, solution given by Dick 
Johnson (Linux-OS) can be used, if all are unable to find what's the 
problem...

here's the output of the two commands you've asked for..

[root@test usr]# ls -ld /usr/bin
drwxr-xr-x    2 root     root        61440 Nov 21 20:30 /usr/bin

[root@test usr]# lsattr -d /usr/bin
su--ia------- /usr/bin

----- Original Message ----- 
From: "S Iremonger" <exxsi@bath.ac.uk>
To: "Pankaj Agarwal" <pankaj@toughguy.net>
Cc: <linux-os@analogic.com>; <linux-kernel@vger.kernel.org>; "Linux Net" 
<linux-net@vger.kernel.org>
Sent: Thursday, February 03, 2005 9:37 PM
Subject: Re: Query - Regarding strange behaviour.


> >its not even allowing me to copy it ...then surely it wont allow me mv as
>>well... what else can i try...
>>[root@test root]# mount
>>/dev/hda2 on / type ext3 (rw)
>>[root@test /]# cd /usr
>>[root@test usr]# cp bin testbin
>>cp: omitting directory `bin'
>
> "cp" does not normally copy direcrories as such by DEFAULT.
>
> Use the "-R" flag on "cp" to make it 'recurse' and copy the whole
>  directory and directory/files under it.
>
> e.g. "cp -R bin bincopy"
>
>
> And, show us all the results of the following 2 commands, please.
>
> ls -ld /usr/bin
> lsattr -d /usr/bin
>
> --S Iremonger <exxsi@bath.ac.uk>
> 

