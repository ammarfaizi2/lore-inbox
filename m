Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTJRNKh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 09:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTJRNKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 09:10:37 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:30728 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261613AbTJRNKg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 09:10:36 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: initrd and 2.6.0-test8
Date: Sat, 18 Oct 2003 15:05:16 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310181505.16184.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seems that something changed between test7 and test8 regarding initrd or romfs 
support. I'm using highly modularized 2.6.0 kernel which has all filesystems 
beside romfs compiled as modules (romfs is compiled inside of kernel).

Modules for my rootfs are loaded from initrd (which is image with romfs as 
filesystem) but starting from test8 kernel is not able to mount initrd 
filesystem - stops with typical message about not being able to mount rootfs.

cset test7 from 20031012_0407 is known to be ok so something was changed later
-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

