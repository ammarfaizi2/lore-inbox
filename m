Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUCXFKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 00:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUCXFKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 00:10:42 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:27861 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S263005AbUCXFKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 00:10:40 -0500
Date: Wed, 24 Mar 2004 10:36:11 +0530
From: mohanlal jangir <mohanlal@samsung.com>
Subject: sleeping in request function
To: linux-kernel@vger.kernel.org
Message-id: <00cc01c4115d$bad44240$7f476c6b@sisodomain.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
 <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz>
 <200403232352.58066.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a USB card reader. It is capable of read/write CF, Smartmedia etc. It
works fine on Linux. While looking into driver, I found that the driver
works between USB host controller and SCSI layer.
Just for learning purpose, I want to write it as block driver. The functions
which performs read/write from the device are blocking. Therefore I can't
call these functions directly from request function. Can somebody tell me
how can I call blocking functions from request function. I tried to set BH
but it didn't work.

Regards
Mohanlal

