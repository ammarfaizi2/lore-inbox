Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVBQEqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVBQEqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 23:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVBQEqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 23:46:32 -0500
Received: from smtp819.mail.sc5.yahoo.com ([66.163.170.5]:52815 "HELO
	smtp819.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262211AbVBQEq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 23:46:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Swsusp, resume and kernel versions
Date: Wed, 16 Feb 2005 23:46:25 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502162346.26143.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

First of all I must say that swsusp has progressed alot and now works
very reliably, at least for my configuration, and I use it a lot. Great
job!

But I think there is one pretty severe issue present - even if swsusp
is not enabled kernel should check if there is an image in swap and
erase it. Today I has somewhat unpleasant experience - after suspending
I accidentially loaded a vendor kernel. I was in hurry and decided that
resume just failed for some reason so I did couple of things and left
the box running. In the evening I realized that I am running vendor kernel
and decided to reboot into my devel. version. What I did not expect is for
the kernel to find a valid suspend image and restore it. As you might
imagine messed up my disk somewhat.

Any chance this can be done?

-- 
Dmitry
