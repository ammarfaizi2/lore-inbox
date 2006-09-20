Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWITS2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWITS2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWITS2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:28:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:1039 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932210AbWITS2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:28:15 -0400
Date: Wed, 20 Sep 2006 14:28:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Flushing writes to PCI devices
Message-ID: <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've heard that to insure proper synchronization it's necessary to flush
MMIO writes (writel, writew, writeb) to PCI devices by reading from the
same area.  Is this equally true for I/O-space writes (inl, inw, inb)?  
What about configuration space writes (pci_write_config_dword etc.)?

Alan Stern

