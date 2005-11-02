Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVKBQMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVKBQMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbVKBQMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:12:33 -0500
Received: from smarthost1.sentex.ca ([64.7.153.18]:13761 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S965114AbVKBQMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:12:32 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <alex@alexfisher.me.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Would I be violating the GPL?
Date: Wed, 2 Nov 2005 11:12:27 -0500
Organization: Connect Tech Inc.
Message-ID: <049c01c5dfc8$37e3b3d0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Fisher [alexjfisher@gmail.com]
> A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
> driver as source code.  They have provided this code source with a
> license stating I won't redistribute it in anyway.

It seems to me that the supplier is violating the GPL.

They've distributed a linux driver.

There are rare exceptions, but most linux drivers are considered
derived works of the kernel and must also be licenced under the GPL
(GPL 2.b).

As such, further restrictions on the rights that come with the driver
are prohibited (GPL 6.). Or, this may count as sublicencing, which is
also prohibited (GPL 4.).

So their licence prohibiting redistribution is in violation of the GPL.

Since no one else has commented on this, I'm wondering if I'm wrong.
Comments?

If I'm right, I believe that GPL 4. allows you to proceed with the
driver as per the GPL...

> My concern is that if I build this code into a module, I won't be able
> to distribute it to customers

..and you can redistribute it.

>                               without violating either the GPL (by not
> distributing the source code), or the proprietary source code license
> as currently imposed by the supplier.

In my mind, this is exactly what the GPL is designed to prevent.

..Stu

