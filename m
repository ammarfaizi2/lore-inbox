Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWDUEyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWDUEyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWDUEyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:54:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37558 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932233AbWDUEyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:54:36 -0400
Date: Thu, 20 Apr 2006 23:54:33 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Remove dead s390 prototype.
Message-ID: <20060421045433.GA30407@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/s390/crypto/z90main.c:367: warning: 'z90crypt_compat_ioctl' declared 'static' but never defined

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/drivers/s390/crypto/z90main.c~	2006-04-20 23:51:26.000000000 -0500
+++ linux-2.6.16.noarch/drivers/s390/crypto/z90main.c	2006-04-20 23:51:39.000000000 -0500
@@ -364,7 +364,6 @@ static ssize_t z90crypt_read(struct file
 static ssize_t z90crypt_write(struct file *, const char __user *,
 							size_t, loff_t *);
 static long z90crypt_unlocked_ioctl(struct file *, unsigned int, unsigned long);
-static long z90crypt_compat_ioctl(struct file *, unsigned int, unsigned long);
 
 static void z90crypt_reader_task(unsigned long);
 static void z90crypt_schedule_reader_task(unsigned long);
