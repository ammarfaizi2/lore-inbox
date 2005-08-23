Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVHWMZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVHWMZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVHWMZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 08:25:59 -0400
Received: from kalyani.insilicasemi.com ([203.145.179.171]:18906 "EHLO
	kalyani.insilicasemi.com") by vger.kernel.org with ESMTP
	id S932147AbVHWMZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 08:25:58 -0400
From: <bunnans@yahoo.com>
To: "'manomugdha biswas'" <manomugdhab@yahoo.co.in>,
       <linux-kernel@vger.kernel.org>
Subject: RE: kernel module seg fault
Date: Tue, 23 Aug 2005 17:55:33 +0530
Message-ID: <006e01c5a7dd$c8395a20$2f08a8c0@varuna>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20050823094231.85102.qmail@web8508.mail.in.yahoo.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biswas,

You need to post the complete kernel dump message and body of your
source code.

-Bunnan
 
-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of manomugdha
biswas
Sent: Tuesday, August 23, 2005 3:13 PM
To: linux-kernel@vger.kernel.org
Subject: kernel module seg fault

Hi,
I have written a kernel module and I can load (insmod)
it without any error. But when i run my module it gets
seg fault at interruptible_sleep_on_timeout();

I have used this function in the following way:

DECLARE_WAIT_QUEUE_HEAD(wq);
init_waitqueue_head(&wq);
interruptible_sleep_on_timeout(&wq, 2);

I am using redhat version 9.0 and kernel version
2.4.20-8.
Could you please give some light on this issue?

Manomugdha Biswas


	

	
		
____________________________________________________
Send a rakhi to your brother, buy gifts and win attractive prizes. Log
on to http://in.promos.yahoo.com/rakhi/index.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


