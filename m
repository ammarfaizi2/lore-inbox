Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVF1UhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVF1UhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVF1UhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:37:17 -0400
Received: from soufre.accelance.net ([213.162.48.15]:12485 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261456AbVF1UdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:33:16 -0400
Message-ID: <42C1B400.9090606@xenomai.org>
Date: Tue, 28 Jun 2005 22:33:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rpm@xenomai.org
Subject: [patch] I-pipe 2.6.12-v0.7-00
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt pipeline patch v0.7-00 has been released:

o Rearranged the file layout according to this proposal:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111932009604355&w=2
o Reworked the interrupt interposition code to shorten the IRQ path
and further reduce the overall impact of this patch on the vanilla
code.
o Fixed IO-APIC related issues.

Patch sequence to build a Linux 2.6.12 tree with I-pipe support:

http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
http://download.gna.org/adeos/patches/v2.6/ipipe/ipipe-2.6.12-v0.7-00.patch

-- 

Philippe.
