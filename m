Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268014AbUHEWMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268014AbUHEWMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHEWKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:10:39 -0400
Received: from hostmaster.org ([212.186.110.32]:63632 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S267906AbUHEWKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:10:17 -0400
Subject: linux-2.6.8-rc2 seems to break grub-0.95
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org, bug-grub@gnu.org
Content-Type: text/plain
Date: Fri, 06 Aug 2004 00:10:14 +0200
Message-Id: <1091743814.2333.20.camel@realborg.geizhals.at>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after compiling and installing linux 2.6.8-rc3 my workstation refused to
boot the new kernel.

Trying to reinstall grub (setup hd0) only made things worse in that it
hanged in "loading stage2..".

Even from floppy I could not boot the new kernel and things got even
worse after reinstalling the files in /boot/grub in that in hanged after
the message "GRUB".

I finally figured out that these problem must be related to the kernel
and after booting linux 2.6.7 and reinstalling the files in /boot/grub
followed by the boot loader everything seems to be working fine again.

Tom

PS: My config is a software RAID 1 with reiserfs on /dev/hda2
and /dev/hdc2

