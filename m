Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSFXV6y>; Mon, 24 Jun 2002 17:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSFXV6x>; Mon, 24 Jun 2002 17:58:53 -0400
Received: from ns.suse.de ([213.95.15.193]:44560 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315338AbSFXV6v>;
	Mon, 24 Jun 2002 17:58:51 -0400
Date: Mon, 24 Jun 2002 23:58:52 +0200
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Would the real 82801E_9 please stand up.
Message-ID: <20020624235852.A3596@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst syncing 2.4.19rc1, I spotted this problem
in pci_ids.h

2.4..

#define PCI_DEVICE_ID_INTEL_82801E_9    0x2459

2.5..

#define PCI_DEVICE_ID_INTEL_82801E_9    0x245b

In a word.. eughhh

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
