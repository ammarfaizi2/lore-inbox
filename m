Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264467AbSIWBZi>; Sun, 22 Sep 2002 21:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSIWBZi>; Sun, 22 Sep 2002 21:25:38 -0400
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:3728 "EHLO
	mailout6-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S264467AbSIWBZh>; Sun, 22 Sep 2002 21:25:37 -0400
Subject: BIOS or kernel APM bug?
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 21:31:02 -0400
Message-Id: <1032744662.6912.69.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently purchased a usb webcam and found that polling /proc/apm
causes the webcam in xawtv to skip.  I can so this either by doing 'cat
/proc/apm' or using the gnome battstat-applet.  Disabling the
battstat-applet and not touching /proc/apm lets xawtv work fine.

Polling /proc/apm also causes clock drift.

I have a Dell Inspiron 8200 laptop (1.6Ghz Pentium 4).  Using kernel
2.4.18 with rmap12h and preempt-kernel patch.

Jamie Strandboge


-- 
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

