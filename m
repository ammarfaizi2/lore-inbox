Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWG2Tmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWG2Tmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbWG2Tmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:42:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:56796 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751350AbWG2Tmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:35 -0400
Date: Sat, 29 Jul 2006 21:42:33 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.18][0/8] x86_64: introduction
Message-ID: <44cbba29.QfGr6DvV8TtvFmB9%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Hopefully the last batch of x86-64/i386 bug fixes for 2.6.18

It have several fixes for serious bugs (except for the defconfig update
and one annoyance fix) 

- Fix the compilation issue in some configs I added earlier on i386
- Fix new Calgary code breaks boot on some x460 setups
- Fix time keeping on Meroms with C3
- Revert a bogus change that broke non ACPI PCI bus discovery on K8
- Fix swiotlb=force (useful as workaround for hw bugs) 

- Remove a filemap.c printk that spams my nfsroot test machines a lot.

Please consider merging.

-Andi
