Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271124AbTGQQAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271131AbTGQQAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:00:46 -0400
Received: from gate.nucleusys.com ([217.79.38.164]:60678 "EHLO
	mastika.nucleusys.com") by vger.kernel.org with ESMTP
	id S271124AbTGQQAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:00:44 -0400
Date: Thu, 17 Jul 2003 19:16:31 +0300 (EEST)
From: Petko Manolov <petkan@nucleusys.com>
To: linux-kernel@vger.kernel.org
Subject: ramdisk on 2.6.0-test1
Message-ID: <Pine.LNX.4.56.0307171907220.637@tequila.nucleusys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried to create a ramdisk image on 2.6.0-test1 and it went pretty bad.

Did:

	dd if=ramdisk of=/dev/ram0
	mount /dev/ram0 /mnt

made a few changes to /mnt then dir 'sync' and:

	dd if=/dev/ram0 of=newrd

When i scanned through "newrd" i didn't see the changes just made.  Tried
with 'umount /mnt' instead of 'sync' - didn't do anything better.


Any idea of what i might be doing wrong?


		Petko
