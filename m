Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTEWEIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 00:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTEWEIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 00:08:18 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:46084 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S263610AbTEWEIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 00:08:17 -0400
Message-ID: <3ECDA1D1.6030507@snapgear.com>
Date: Fri, 23 May 2003 14:21:37 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] driver for DiskOnChip Millennium Plus and INFTL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Here is a patch that adds support to the kernel MTD drivers
for the M-System's Disk-On-Chip Millennium Plus family of
devices. It also contains an INFTL (Inverse NAND Flash Translation
Layer) driver as well.

You can get it at either of:

  ftp://ftp.snapgear.org/pub/patches/mplus-20030414.patch.gz
  http://www.uclinux.org/pub/uClinux/misc/mplus-20030414.patch.gz

This patch is against Linux-2.4.20 source.

The Millennium Plus register map is quite different to their
other devices, and so needs a new sub-driver. The INFTL layer
is also quite different to their older NFTL code, so a new
sub-driver for that too.

This code is all GPL (with the blessing of M-System), and based
on the existing Disk-On-Chip support in MTD.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

