Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUJRKdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUJRKdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 06:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUJRKdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 06:33:03 -0400
Received: from gtw.mailserveren.com ([213.236.175.186]:30152 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S265943AbUJRKbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 06:31:06 -0400
Subject: Kernel upgrade, need workaround for libata detection
From: Hans Kristian Rosbach <hk@isphuset.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1098095446.21895.129.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Oct 2004 12:30:46 +0200
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hk@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forget the kernel numbers (around 2.6.5 I think), but those
are not important in this matter.

I have installed linux on a few computers with an old 2.6 kernel,
they both have sata disks recogniced as hda and hdc. But a problem
arises when I try to upgrade to a newer kernel (FC2 kernels), the
disks are then sda and sdb.

Now this is fine with me, but the big problem here is that these
disks are in a raid. So I need to find a solution for booting and
finding root on these disks.

I'm thinking about the following solutions:
1. Is there any kernel parameter to disable libata, so that it
   will revert to good old hda and hdc?
2. Can I reconfigure the raid to use hda,hdc,sda,sdb even if only
   hda and hdc is available while reconfiguring?
   Will it work correctly when I reboot and they are sda and sdb
   instead? Any hints as to how to do this safely?
3. Any way to make the kernel know that hda==sda ?

I apologise for my bad wording today, It's not a good day (flu).

-HK

