Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWIUUc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWIUUc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWIUUc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:32:59 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:744 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S1750792AbWIUUc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:32:59 -0400
Subject: Smaller compressed kernel source tarballs?
From: Dax Kelson <dax@gurulabs.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 14:32:57 -0600
Message-Id: <1158870777.24172.23.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today as I was watching the linux-2.6.18.tar.bz2 slowly download I
thought it would be nice if it could be made smaller.

The 7zip program/algorithm is free software (LGPL) and can be obtained
from http://www.7-zip.org/ and it is distributed with several
distributions (it is in Fedora Core 6 extras for example).

Here are the numbers:

ls -al
-rw-r--r--  1 root root 240138240 Sep 21 13:55 linux-2.6.18.tar
-rw-r--r--  1 root root  34180796 Sep 21 13:42 linux-2.6.18.tar.7z
-rw-r--r--  1 root root  41863580 Sep 21 13:45 linux-2.6.18.tar.bz2
-rw-r--r--  1 root root  52467357 Sep 21 13:13 linux-2.6.18.tar.gz

ls -alh
-rw-r--r--  1 root root 230M Sep 21 13:55 linux-2.6.18.tar
-rw-r--r--  1 root root  33M Sep 21 13:42 linux-2.6.18.tar.7z
-rw-r--r--  1 root root  40M Sep 21 13:45 linux-2.6.18.tar.bz2
-rw-r--r--  1 root root  51M Sep 21 13:13 linux-2.6.18.tar.gz

Smaller the better, especially with the international audience.

Dax Kelson

