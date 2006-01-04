Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965272AbWADTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbWADTym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWADTyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:54:41 -0500
Received: from imo-m27.mx.aol.com ([64.12.137.8]:38835 "EHLO
	imo-m27.mx.aol.com") by vger.kernel.org with ESMTP id S965272AbWADTyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:54:40 -0500
Date: Wed, 04 Jan 2006 14:54:27 -0500
From: andyliebman@aol.com
Message-Id: <8C7DF7FCD8430A9-C8C-4BB2@MBLK-M38.sysops.aol.com>
X-MB-Message-Source: WebUI
X-MB-Message-Type: User
X-Mailer: AOL WebMail 15106
Subject: Atapi CDROM, SATA OS drive, and 2.6.14+ kernel
Content-Type: text/plain; charset="us-ascii"; format=flowed
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-AOL-IP: 64.12.136.82
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can somebody tell me what changed in the 2.6.14 kernel that doesn't 
allow me to access my CDROM drive when my OS drive is SATA?

I have an image of a working 2.6.14 system that was installed on an IDE 
drive. I restored the image to a SATA drive, changed a few lines in 
/etc/fstab and /etc/lilo.conf so that they refer to /dev/sd* devices 
instead of /dev/hd* devices.

I also modified /etc/modprobe.conf so that it is identical to the file 
that Mandriva 2006 produces when installed directly to a SATA drive 
(but Mandriva 2006 has the 2.6.12.x kernel).

I can't mount my CDROM when running 2.6.14.x

I have googled this for several days. I have seen posts about passing 
options to the kernel and including extra lines in modprobe.conf like:

libata atapi_enabled=1

Can't find the magic formula. Help would be appreciated.

Andy Liebman
