Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWGYQZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWGYQZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWGYQZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:23707 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932449AbWGYQZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:25:06 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: VIA x86-64 bootlogs needed
Date: Tue, 25 Jul 2006 18:24:30 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251824.30504.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For some APIC code rework I would like to collect some statistics on
VIA APIC setups.

If you have a system with VIA chipset running a recent (2.6.16+) x86-64 kernel 
please boot the system with apic=verbose on the kernel command and send me

- boot output (/var/log/boot.msg or dmesg -s100000000 output after boot)
- dmidecode output
- lspci  -v output

Thanks,

-Andi
