Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314357AbSDROGM>; Thu, 18 Apr 2002 10:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314359AbSDROGL>; Thu, 18 Apr 2002 10:06:11 -0400
Received: from em.njupt.edu.cn ([202.119.230.11]:9688 "HELO em.njupt.edu.cn")
	by vger.kernel.org with SMTP id <S314357AbSDROGL>;
	Thu, 18 Apr 2002 10:06:11 -0400
From: "yangrunhua" <yangrunhua@njupt.edu.cn>
To: <linux-kernel@vger.kernel.org>
Subject: Questions about using usbnet.c
Date: Thu, 18 Apr 2002 22:08:28 +0800
Message-ID: <000601c1e6e2$83a28c70$d1010a0a@yu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!
When I use dev_queue_xmit( ) to send packets directly to the usb device
from a netfilter hook( in a ipt target function),
( I want to forward packet from eth0 directly into usb0, so I do it like
that)
the rate is so slow that dev_queue_xmit always returns 1 which means
droped ( 200kbits/s at most). 
But when I used a user-space (TCP) program to send packet, and receive
on the other machine,
the rate grew up to 6Mbits/s.
Is there any limit on using dev_queue_xmit( ) directly ?
Regards,
yangrunhua



