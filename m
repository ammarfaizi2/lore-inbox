Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270650AbTHJUe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270667AbTHJUe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:34:27 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:48595 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S270650AbTHJUeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:34:23 -0400
Date: Sun, 10 Aug 2003 22:34:19 +0200 (MEST)
Message-Id: <200308102034.h7AKYJsr014788@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: oliver@neukum.org
Subject: HFS error messages in 2.6.0-test3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changing a HFS partition from 2.6.0-test3 on ppc32 results
in messages like the following in the kernel's log:

hfs_cat_put: trying to free free entry: c5f382a0
hfs_cat_put: trying to free free entry: c5047460

(from 'touch /mnt/macos/Temp/junk')

hfs_cat_put: trying to free free entry: c5047460
hfs_cat_put: trying to free free entry: c5f382a0

(from 'sync' after the previous 'touch')

I don't know how serious these messages are, but they don't
appear when I'm using a 2.4 kernel.

(I install new kernels in a MacOS9/HFS partition because BootX
is the only boot loader that works on my OldWorld PowerMac.)

/Mikael
