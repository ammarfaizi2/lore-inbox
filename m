Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUCaN0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 08:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCaN0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 08:26:40 -0500
Received: from vtens.prov-liege.be ([193.190.122.60]:20959 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261774AbUCaN0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 08:26:39 -0500
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01E2575C@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.4.25 vanilla on proliant
Date: Wed, 31 Mar 2004 15:26:37 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I'm trying to install a 2.4.25 on Advanced server 2.1 Proliant
Compaq.
	I keep having the following :
		...
		ds:no socket drivers loaded
		kmod: failed to exec /sbin/modprobe -s -k block_major_104,
errno=2
		VFS : cannot open root device "cciss/c0d0p6" or 68:06
		Please append a correct "root=" boot option
		kernel panic : VFS : unable to mount root fs on 68:06

	However I 'make modules_install' on cciss,rd,aic7xxx,ds,cpqarray
amongst others
	then mkinitrd /boot/initrd2425 2.4.25

	grub snippet :
	menu.lst : title 2.4.25
			root (hd0,0)
			kernel /2425 ro root=/dev/cciss/c0d0p6
			initrd /initrd2425


	Someone could help me ?

Regards,
Fabian
