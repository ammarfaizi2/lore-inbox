Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWCGFzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWCGFzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWCGFzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:55:22 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:15055 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750870AbWCGFzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:55:21 -0500
Message-ID: <440D1FEC.1070701@jp.fujitsu.com>
Date: Tue, 07 Mar 2006 14:53:48 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 0/4] PCI legacy I/O port free driver (take5)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an updated set of patches for PCI legacy I/O port free drivers,
which incorporate feedbacks. Summary of changes from the previous
version is as follows:

    - Use pci_enable_device_bars() approach instead of 'no_ioport'
      approach. Please see the header of patch 1/4 for specific.

    - Update Documentation/pci.txt

    - Changed e1000 driver to use pci_enable_device_bars() instead of
      'no_ioport'.

    - Changed lpfc driver to use pci_enable_device_bars() instead of
      'no_ioport'

Greg, could you consider applying those into your test tree?

Thanks,
Kenji Kaneshige
