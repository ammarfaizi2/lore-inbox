Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTK0Ogp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 09:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTK0Ogo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 09:36:44 -0500
Received: from tranchant.plus.com ([81.174.183.177]:16068 "EHLO
	tranchant.plus.com") by vger.kernel.org with ESMTP id S264531AbTK0Ogn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 09:36:43 -0500
Message-ID: <3FC60BF2.4020008@tranchant.plus.com>
Date: Thu, 27 Nov 2003 14:36:34 +0000
From: Mark Tranchant <mark@tranchant.plus.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] README, kernel 2.6.0-test11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.122 () AWL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial but long-standing fix which I submitted a couple of days ago. 
Here it is in proper lkml-approved form:

-----------------------------

--- README.orig 2003-11-27 14:30:29.000000000 +0000
+++ README      2003-11-27 14:30:48.000000000 +0000
@@ -119,7 +119,7 @@
     cd /usr/src/linux-2.6.N
     make O=/home/name/build/kernel menuconfig
     make O=/home/name/build/kernel
-   sudo make O=/home/name/build/kernel install_modules install
+   sudo make O=/home/name/build/kernel modules_install install

     Please note: If the 'O=output/dir' option is used then it must be
     used for all invocations of make.


-----------------------------

-- 
Mark Tranchant.
mark@tranchant.plus.com


