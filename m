Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVEYGUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVEYGUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVEYGUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:20:19 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:29117 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S262271AbVEYGTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:19:49 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Guddu Guddu'" <guddu_blr123@yahoo.co.in>, <linux-kernel@vger.kernel.org>
Subject: RE: Mounting cramfs from RAM address
Date: Wed, 25 May 2005 08:19:47 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C79D6@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66802E5E89C@exmail1.se.axis.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One way is to create a MTD RAM device and mount that. Look in 
arch/cris/drivers/axisflashmap.c for example (search for RAM device).

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Guddu Guddu
Sent: Wednesday, May 25, 2005 8:08 AM
To: linux-kernel@vger.kernel.org
Subject: Mounting cramfs from RAM address


Hi,

I want to mount my cramfs stored at a particular
address in RAM (i.e 0x8100_0000). What is the best way
to do so?

-- guddu



________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

