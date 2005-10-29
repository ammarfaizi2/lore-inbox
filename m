Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVJ2NSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVJ2NSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 09:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJ2NSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 09:18:47 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:12714 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1750982AbVJ2NSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 09:18:46 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200510291318.j9TDIjmi018556@clem.clem-digital.net>
Subject: 2.6.14-git1 fails compile -- i386/pci/fixup.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 29 Oct 2005 09:18:45 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fyi:

  CC      arch/i386/pci/fixup.o
arch/i386/pci/fixup.c:401: toshiba_ohci1394_dmi_table causes a section type conflict
make[1]: *** [arch/i386/pci/fixup.o] Error 1
make: *** [arch/i386/pci] Error 2

-- 
Pete Clements 
