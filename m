Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263481AbRFFFcF>; Wed, 6 Jun 2001 01:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263485AbRFFFbz>; Wed, 6 Jun 2001 01:31:55 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:45812 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S263481AbRFFFbt>;
	Wed, 6 Jun 2001 01:31:49 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: USBDEVFS_URB_TYPE_INTERRUPT
Date: Wed, 6 Jun 2001 01:31:41 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGGEIBCIAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I was designing a USB based device and was looking through the 2.4.5 kernel
code, and noticed that while it supports bulk, iso, and control types, there
is no support for interrupt types.  A grep through the entire kernel source
code reveals that USBDEVFS_URB_TYPE_INTERRUPT defined in
linux/usbdevice_fs.h, but no where is it used.  Any thoughts as to why that
might be?

	A google search didn't seem to turn up any answers either.

	-- John

