Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbWADSYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWADSYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbWADSYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:24:00 -0500
Received: from web60217.mail.yahoo.com ([209.73.178.105]:32914 "HELO
	web60217.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965255AbWADSX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:23:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NLPb7h2yzgRx2MoYGIGj1Ww0+yV+UJzS8Tli2FKFscd6p0V9rnef3D7VHQVPOKp8kpkmrRxOHJB2gXAjWDf91xuZpc86xaw4+20lZ0Bxn40JA1Rq5noV2oHhW/k7vs7EWrfK2VWgYWCohQfw7YZ9r/lp17aJ7luwmheDDqvUpkc=  ;
Message-ID: <20060104182356.14925.qmail@web60217.mail.yahoo.com>
Date: Wed, 4 Jan 2006 10:23:56 -0800 (PST)
From: anil dahiya <ak_ait@yahoo.com>
Subject: makefile for 2.6 kernel
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello 
I want to make kernel module dummy.ko using multiple
.c and .h files. In short i am telling .c and .h files
with directory structure

1> dummy.ko should made be using module1.ko and
module2.o (i.e 
   module2.o uses module1.ko to make dummy.ko)

2> module1.ko made using a1/a1.c & a2/a2.c and  both
.c file   
   use /home/include/a.h 
3> module2.o should made using b/b1.c which use   
   use /home/module2/include/b.h 

Suggest me tht should make i make module2.o or
module2.ko and then combine it with module1.o to make
dummy.ko 


/home/------
             |_ include _
             |           |
             |           a.h 
             | 
             |___module1_
             |           |__ a1 ____
             |           |          | 
             |           |         a1.c 
             |           |
                         |__ a2 ____
             |           |           | 
             |           |         a2.c 
             |
             |___ moudule2_
             |             |             
             |             |__include _
             |             |           |
             |             |           b.h 
             |             |___b1__
             |                     | 
             |                   b1.c 
        
                                   
Looking forward for ur reply 
thanks in advance
---- Anil 


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

