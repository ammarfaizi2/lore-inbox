Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbUKPTIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbUKPTIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKPTIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:08:21 -0500
Received: from outbound01.telus.net ([199.185.220.220]:62684 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S262095AbUKPTIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:08:19 -0500
Subject: Boot failure, 2.6.10-rc2
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 12:08:36 -0700
Message-Id: <1100632116.4388.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  When booting 2.6.10-rc2, I get 
Warning: unable to open an initial console
(and the boot process then stalls).

My system has the following already configured:
crw-------  1 bob root 5, 1 Nov 16 10:10 /dev/console

/etc/fstab shows:
none                    /dev/pts                devpts  gid=5,mode=620
0 0

My kernel configuration includes the following:
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

I have appended console=/sbin/bash to the kernel boot line (which does
not meet with success).

If it makes any difference, my system is FC3.  Is there anything special
I have to do to udev (or a particular version I have to get in order to
start a console after the kernel is loaded (and the memory is freed
after it's shuffled from himem to lomem)?

Please reply to me directly as I'm not on the list.

TIA,

Bob  
-- 
Bob Gill <gillb4@telusplanet.net>

