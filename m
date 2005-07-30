Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVG3C3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVG3C3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVG3C3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:29:10 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:14734 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262714AbVG3C3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 22:29:09 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Sat, 30 Jul 2005 12:28:54 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com>
In-Reply-To: <42EAABD1.8050903@pobox.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 18:21:05 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>
>[speaking to the audience]  I wouldn't mind if someone did a pass 
>through pci_ids.h and removed all the constants that are not being used. 

Only these seem not referenced by source:
PCI_CLASS_SYSTEM_PCI_HOTPLUG
PCI_DEVICE_ID_CYRIX_PCI_MASTER
PCI_DEVICE_ID_HP_PCI_LBA
PCI_DEVICE_ID_NP_PCI_FDDI
PCI_DEVICE_ID_UPCI_RM3_4PORT
PCI_DEVICE_ID_UPCI_RM3_8PORT

Source macros refer to:
  BROOKTREE	sound/pci/bt87x.c
  YAMAHA	sound/oss/ymfpci.c

6 from 2329 entries hardly worth it?

Grant.

