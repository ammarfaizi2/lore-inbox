Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272503AbTHEP6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272506AbTHEP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:58:17 -0400
Received: from [132.216.18.133] ([132.216.18.133]:29712 "EHLO
	signal.ckut-fake.ca") by vger.kernel.org with ESMTP id S272503AbTHEP6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:58:16 -0400
Date: Tue, 5 Aug 2003 11:58:12 -0400
From: Marc Heckmann <mh@nadir.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre9, 8139too driver: eth0: Too much work at interrupt
Message-ID: <20030805155811.GA17539@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[I searched lkml archives for this, but nothing really useful came up,
othewr than it did not happen on much older versions of 2.4.x]

When I transfer any large files via scp or other means on the local
100 Mbps network, I get the following error messages:

eth0: Too much work at interrupt: IntrStatus=0x0040

Are they just debug printk's? My NFS connections stall and sometimes
cause errors in programs writing via NFS. (The machine exhibiting the
symptoms is the NFS client.)

This is with 2.4.22-pre9, UP IO-APIC and ACPI enabled. The board is a
Gigabyte GA7VXP with onboard 8139 ethernet.

This also happens with 2.4.21. I haven't tried any older kernels since
the machine is new.

Does anyone have any ideas? thanks in advance.

-m


