Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUGJAc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUGJAc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUGJAc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:32:57 -0400
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:24197 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265773AbUGJAcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:32:55 -0400
From: "Robert Lowery" <rlowery@optusnet.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: [OT] Belkin Bluetooth Access Point GPL violation
Date: Sat, 10 Jul 2004 10:34:47 +1000
Message-ID: <000001c46615$b4608fb0$0302a8c0@vaio>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently purchase a Belkin Bluetooth Access Point with USB Print
Server
http://catalog.belkin.com/IWCatProductPage.process?Merchant_Id=&Section_
Id=200583&pcount=&Product_Id=134669

By telnetting into it, I was able to find that it runs linux,
specifically uClinux version 2.0.38.1pre7arm.

Investigating further, I found the device is made by
www.rovingnetworks.com

The latest version of firmware may be obtained from
http://www.belkin.com/firmware/bluetooth/f8t030/flash.bin or a beta
version that includes PAN support at
www.rovingnetworks.com/belkinpan4.bin

I contacted them at support@rovingnetworks.com  Mike Conrad replied to
my request.

Initially, he said they wanted $5000 for a source code license.  When I
Informed him of their GPL violation, he said
"you could possibly have the linux os changes we made, but our bluetooth
stack, for example, is not covered under the GPL. And we have special
tools that enable web download, and  create the image that is loaded,
etc."

Looking at the running system, it is not running any kernel modules, so
I would expect the bluetooth stack to be compiled into the kernel
proper, which in my understanding would mean they have to release the
source.

This was a few weeks ago.  I contacted him today to see what they had
decided and got
"The developer who works on it here was on vacation, now he is back but
swamped with work.  It is not a very high priority for us.  We may put
something out, but I would not hold your breath for it."

Would any one on the list be interested in taking this further?

My main interest in this would be be to add additional USB support eg
USB mass storage

-Robert

