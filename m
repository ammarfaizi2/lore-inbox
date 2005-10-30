Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVJ3OD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVJ3OD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVJ3OD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:03:27 -0500
Received: from dvhart.com ([64.146.134.43]:6312 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750959AbVJ3OD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:03:26 -0500
Date: Sun, 30 Oct 2005 06:03:28 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Subject: 2.6.14-git1 (and -git2) build failure on AMD64
Message-ID: <16080000.1130681008@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC      arch/x86_64/pci/../../i386/pci/fixup.o
arch/x86_64/pci/../../i386/pci/fixup.c: In function `pci_fixup_i450nx':
arch/x86_64/pci/../../i386/pci/fixup.c:13: error: pci_fixup_i450nx causes a section type conflict
make[1]: *** [arch/x86_64/pci/../../i386/pci/fixup.o] Error 1
make: *** [arch/x86_64/pci] Error 2

Config: http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
