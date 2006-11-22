Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161830AbWKVIEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161830AbWKVIEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161838AbWKVIEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:04:11 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:56982 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161830AbWKVIEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:04:09 -0500
Message-ID: <456404A8.4030205@jp.fujitsu.com>
Date: Wed, 22 Nov 2006 17:04:56 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg KH <greg@kroah.com>, Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
Subject: [PATCH 0/5] PCI legacy I/O port free driver
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is a set of updated patches for "PCI legacy I/O port free drivers"
that Kaneshige-san originally proposed, once accepted to -mm tree but
reverted.

Previous discussion can be referred by following:
 http://lkml.org/lkml/2006/6/5/117

I reviewed all patches in this set and refreshed them to fit latest,
2.6.19-rc6.

    o [PATCH 1/5] Update Documentation/pci.txt
    o [PATCH 2/5] PCI : Move pci_fixup_device and is_enabled
    o [PATCH 3/5] PCI : Add selected_regions funcs
    o [PATCH 4/5] e1000 : Make Intel e1000 driver legacy I/O port free
    o [PATCH 5/5] lpfc : Make Emulex lpfc driver legacy I/O port free

Thanks,
H.Seto

