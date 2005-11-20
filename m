Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVKTTwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVKTTwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 14:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVKTTwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 14:52:43 -0500
Received: from host-84-222-72-73.cust-adsl.tiscali.it ([84.222.72.73]:15547
	"EHLO lxnaydesign.net") by vger.kernel.org with ESMTP
	id S932074AbVKTTwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 14:52:43 -0500
From: Fabio Erculiani <lxnay@lxnaydesign.net>
To: linux-kernel@vger.kernel.org
Subject: [IDEA] Enable debugging in userspace?
Date: Sun, 20 Nov 2005 20:54:42 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511202054.42479.lxnay@lxnaydesign.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, one idea is floating around me and bugging my brain (read: headache).
If I could be a newbie, and if I have a problem with the latest and greatest 
linux distro, I start googling and looking for a solution. The problem is 
that someone write that I have to enable debugging mode in kernel 
configuration, recompile everything and reboot. That's quite impossible for a 
newbie, isn't it?
So, why don't add an option to enable/disable debugging mode in sysfs?

Like:

/* DEBUG MODE ON */
echo "1" > /sys/kernel/debugging/debug_mode
/* DEBUG MODE OFF */
echo "0" > /sys/kernel/debugging/debug_mode

I know that debugging code might (remove "might") increase the kernel size, 
but men, we have >256MB of RAM and >1GB of hard drive space.

I'm not subscribed to the ML but I read that on lkml.org

BR,
-- 
Fabio Erculiani
www.lxnaydesign.net
RR4/RR64 Developer - Gentoo made easy
