Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWAJRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWAJRoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWAJRoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:44:23 -0500
Received: from web60212.mail.yahoo.com ([209.73.178.115]:49820 "HELO
	web60212.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932084AbWAJRoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:44:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QxFiL82HHYtoB6r6v7Abo/ZkC9EJQcfRFzUWfPTPSATpxcG7nfz7PX6eMlRcv8ufjWX0EOUXg4NTeZ24OXkHV1uw5lg1T1avVbMx8pL/VNrkIx5HZdqoGfuudVzDGNVKRhuMMPrBAWWDkpN5aBN8EoVbHSLSPTGffn4atuvkz3Y=  ;
Message-ID: <20060110174419.56611.qmail@web60212.mail.yahoo.com>
Date: Tue, 10 Jan 2006 09:44:19 -0800 (PST)
From: anil dahiya <ak_ait@yahoo.com>
Subject: makefile for 2.6 kernel
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org, sam@ravnborg.org
In-Reply-To: <20060104182356.14925.qmail@web60217.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam
Thanks fop your help ..but my problem is not solved it
...i putting my real problem here below.

1>my fist need is to make  module1.ko made using
a1/a1.c , a1/a11.c & a2/a2.c a2/a22.c and all .c file
use /home/include/a.h 

 
2>Now my 2nd need is to make module2.ko using
module1.ko and b/b1.c & b/b11.c (these both .c files
use /home/include/a.h and /home/module2/include/b.h) 

In short my directory  structure is as:
  
/home/------
              |_ include _
              |           |
              |           a.h 
              | 
              |___module1_
              |           |__ a1 ____________
              |           |          |       |
              |           |         a1.c   a11.c
              |           |
                          |__ a2 ___________
              |           |           |     |
              |           |         a2.c   a22.c
              |
              |___ moudule2_
              |             |             
              |             |__include _
              |             |           |
              |             |           b.h 
              |             |___b1________
              |                     |     |
              |                   b1.c   b11.c
         
                                    
Looking forward for ur reply 
thanks in advance
 ---- Anil 


--- anil dahiya <ak_ait@yahoo.com> wrote:

> hello 
> I want to make kernel module dummy.ko using multiple
> .c and .h files. In short i am telling .c and .h
> files
> with directory structure
> 
> 1> dummy.ko should made be using module1.ko and
> module2.o (i.e 
>    module2.o uses module1.ko to make dummy.ko)
> 
> 2> module1.ko made using a1/a1.c & a2/a2.c and  both
> .c file   
>    use /home/include/a.h 
> 3> module2.o should made using b/b1.c which use   
>    use /home/module2/include/b.h 
> 
> Suggest me tht should make i make module2.o or
> module2.ko and then combine it with module1.o to
> make
> dummy.ko 
> 
> 
> /home/------
>              |_ include _
>              |           |
>              |           a.h 
>              | 
>              |___module1_
>              |           |__ a1 ____
>              |           |          | 
>              |           |         a1.c 
>              |           |
>                          |__ a2 ____
>              |           |           | 
>              |           |         a2.c 
>              |
>              |___ moudule2_
>              |             |             
>              |             |__include _
>              |             |           |
>              |             |           b.h 
>              |             |___b1__
>              |                     | 
>              |                   b1.c 
>         
>                                    
> Looking forward for ur reply 
> thanks in advance
> ---- Anil 
> 
> 
> 		
> __________________________________________ 
> Yahoo! DSL – Something to write home about. 
> Just $16.99/mo. or less. 
> dsl.yahoo.com 
> 
> 
> --
> Kernelnewbies: Help each other learn about the Linux
> kernel.
> Archive:      
> http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
> 



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

