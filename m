Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbTATJOl>; Mon, 20 Jan 2003 04:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTATJOl>; Mon, 20 Jan 2003 04:14:41 -0500
Received: from fmr01.intel.com ([192.55.52.18]:22732 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261847AbTATJOk>;
	Mon, 20 Jan 2003 04:14:40 -0500
Date: Mon, 20 Jan 2003 17:21:43 +0800 (CST)
From: stanley.wang@linux.co.intel.com
X-X-Sender: stanley@manticore.sh.intel.com
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: How about use sysfs instead of pcihpfs?
Message-ID: <Pine.LNX.4.44.0301201711480.2265-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg!
After reading the pci_hotplug_core.c, I found there are many codes 
that are used to implement the pcihpfs. And how about using sysfs instead
of pcihpfs ? I think it could make the pci_hotplug_core.c smaller. Another
pro is that we will nerver be bothered by the pcihpfs' bug.
How you think about it?

Regards,
Stanley Wang

-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


