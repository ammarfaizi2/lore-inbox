Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVDFMJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVDFMJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVDFMC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:02:57 -0400
Received: from host217-40-213-68.in-addr.btopenworld.com ([217.40.213.68]:16857
	"EHLO SERRANO.CAM.ARTIMI.COM") by vger.kernel.org with ESMTP
	id S262143AbVDFL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:56:20 -0400
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Dave Korn'" <dave.korn@artimi.com>,
       "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "'Christophe Saout'" <christophe@saout.de>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Jan Hubicka'" <hubicka@ucw.cz>,
       "'Gerold Jury'" <gerold.ml@inode.at>, <jakub@redhat.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <gcc@gcc.gnu.org>
Subject: RE: [BUG mm] "fixed" i386 memcpy inlining buggy
Date: Wed, 6 Apr 2005 12:56:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <SERRANOEKRuYDlrjbud0000007e@SERRANO.CAM.ARTIMI.COM>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcU6mMx7UselsSWPRcmlLlhiWHQ0KAAAMLGQAAFhoWAAAB5CoA==
Message-ID: <SERRANOOlbcrYP0QzBx00000080@SERRANO.CAM.ARTIMI.COM>
X-OriginalArrivalTime: 06 Apr 2005 11:56:21.0809 (UTC) FILETIME=[A6885210:01C53A9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Original Message----
>From: Dave Korn
>Sent: 06 April 2005 12:53

> ----Original Message----
>> From: Dave Korn
>> Sent: 06 April 2005 12:13
> 
>> ----Original Message----
>>> From: Dave Korn
>>> Sent: 06 April 2005 12:06
>> 
>> 
>>   Me and my big mouth.
>> 
>>   OK, that one does work.
>> 
>>   Sorry for the outburst.
>> 
> 
> 
> .... well, actually, maybe it doesn't after all.
> 
> 
>   What's that uninitialised variable ecx doing there eh?

  Oh, I see, it's there as an output so it can be matched as an input by the
"0" constraint.

  Ok, guess it does.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

