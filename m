Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266900AbUGVS5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266900AbUGVS5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUGVS5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:57:12 -0400
Received: from pm-mx6.mgn.net ([195.46.220.208]:16374 "EHLO mx.noos.fr")
	by vger.kernel.org with ESMTP id S266900AbUGVS5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:57:08 -0400
X-Mailbox-Line: From pascal.ronecker@centrale-lille.net Thu Jul 22 20:57:05 2004
Subject: System.map with kernel 2.6.7
From: Pascal Ronecker <pascal.ronecker@centrale-lille.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1090522625.8583.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jul 2004 20:57:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm surprised with a dumb problem at boot time. No answer anywhere on
google. At boot the kernel complains :
kernel : cannot find map.

This is supposed to mean : no System.map file where it should be.
But I swear it is :

lrwxr-xr-x    1 root     root           16 Jul 17 12:03 System.map ->
System.map-2.6.7
-rw-r--r--    1 root     root         837K Jul 22 18:49 System.map-2.6.7
lrwxrwxrwx    1 root     root            1 Nov  5  2003 boot -> .
drwxr-xr-x    2 root     root         1.0K Jul 22 19:20 grub
-rw-r--r--    1 root     root         1.7M Jul 22 18:49 kernel-2.6.7

I tried to rebuild the kernel (in case I missed the file copy) : same
result.

Am I wrong somewhere ?

(I only did make bzImage and copied the kernel image and system.map
files in /boot, as usually)

thx !

bye





