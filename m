Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSGHO7j>; Mon, 8 Jul 2002 10:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSGHO7i>; Mon, 8 Jul 2002 10:59:38 -0400
Received: from hera.cwi.nl ([192.16.191.8]:14581 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316960AbSGHO7i>;
	Mon, 8 Jul 2002 10:59:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 8 Jul 2002 17:02:18 +0200 (MEST)
Message-Id: <UTC200207081502.g68F2I701471.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: IDE, util-linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday util-linux 2.11t was released.
As always, comments are welcome.

Wanted to continue some usb-storage work on 2.5 and
recklessly booted 2.5.25. It survived for several hours,
then deadlocked. Two filesystems turned out to be corrupted.
Wouldn't mind if the rock solid 2.4 handling of HPT366
was carefully copied to 2.5, that today quickly causes
corruption and quickly deadlocks or crashes.
[Yes, these are independent bugs. The fact that the current
IDE code writes to random disk sectors is much more annoying
than the fact that it crashes and deadlocks. This random
writing is observed only on disks on the HPT366 card.]

Andries

