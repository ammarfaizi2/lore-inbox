Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265483AbUGDJZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbUGDJZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 05:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGDJZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 05:25:26 -0400
Received: from web20806.mail.yahoo.com ([216.136.226.195]:1156 "HELO
	web20806.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265483AbUGDJZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 05:25:24 -0400
Message-ID: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
Date: Sun, 4 Jul 2004 02:25:23 -0700 (PDT)
From: Fawad Lateef <fawad_lateef@yahoo.com>
Subject: Need help in creating 8GB RAMDISK
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am creating a RAMDISK of 7GB (from 1GB to 8GB). I
reserved the RAM by changing the code in
arch/i386/mm/init.c .......... 

But I am not able to access the RAM from 1GB to 8GB in
a kernel module ........ after crossing the 4GB RAM,
the system goes into standby state. But if I insert
the same module 2 times means one for 1GB to 4GB and
other for 4GB to 8GB. and mount them seprately both
works fine ............ 

Can any one tell me the reason behind this ??? I think
that in a single module we can't access more than 4GB
RAM ...... If this is the reason then what to do ??? I
need 7GB RAMDISK as a single drive ....

Thanks and Regards,

Fawad Lateef


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail
