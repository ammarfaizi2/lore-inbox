Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUBHLLC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUBHLLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:11:01 -0500
Received: from [212.53.96.198] ([212.53.96.198]:24192 "EHLO mail.econophone.ch")
	by vger.kernel.org with ESMTP id S263370AbUBHLK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:10:59 -0500
Subject: 2.6.3-rc1 - initrd can't find any volume groups ?
From: =?ISO-8859-1?Q?Jo=EBl?= Bourquard <numlock@freesurf.ch>
Reply-To: numlock@freesurf.ch
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1076238646.18405.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 08 Feb 2004 12:10:47 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying the new 2.6.3-rc1 with the working config file from 2.6.2. It
goes fine until initrd's lvm executable looks for volume groups to
activate.

Two new things here:
- it doesn't find the VG on /dev/hda anymore
- for each nbd0..127 it now complains about block 0 not being
accessible.

I can't exactly say what happens about hda, since it scrolls so fast
right after (trying to scan all nbd's twice). I've tried to scroll lock
but it stopps too late.

Again using 2.6.2 it boots fine, and says nothing about nbd. I have only
one hdd, and no NBD's.

Does anyone with root fs on LVM encounter that too?

Thanks
Joël

