Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269637AbRHHX1Y>; Wed, 8 Aug 2001 19:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269638AbRHHX1O>; Wed, 8 Aug 2001 19:27:14 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:34059 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269637AbRHHX1H>;
	Wed, 8 Aug 2001 19:27:07 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Duplicate symbols in usb cams, -ac
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Aug 2001 09:27:14 +1000
Message-ID: <6380.997313234@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.7-ac9, if both ultracam and cam are built into the kernel, cams
is a duplicate symbol.

drivers/usb/ultracam.o(.data+0x0): multiple definition of `cams'
drivers/usb/ibmcam.o(.data+0x0): first defined here

