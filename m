Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759949AbWLELHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949AbWLELHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759952AbWLELHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:07:13 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:64795 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759949AbWLELHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:07:10 -0500
Date: Tue, 5 Dec 2006 03:07:00 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B70Ft017456@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] 2.6.19 perfmon2 : introduction
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Perfmon2 is a new kernel subsystem which provides access to the
hardware performance counters present all all modern processors.
It provides suport for basic counting and sampling on a per-thread
or system-wide basis. It supports all the major processor architectures.

The following series of patches includes the generic perfmon2
subsystem and the support for i386, x86_64, and powerpc. The perfmon2
subsystem also works on MIPS and all Itanium processors. The Itanium support
is not posted because it does not easily accomodate the 100k message
limit of lkml. The powerpc support is still very preliminary.

The patches are relative to 2.6.19

I have already posted on the list about this subsystem. I am submitting 
today to get reviews and make progress towards getting the subsystem
merged into the mainline kernel.

The patches are split up between common and arch-specific. Each part
is further decomposed into new files and modified files. The generic
code is now split up by functionality to make reading easier.

For each new or modified files, I provide a detailed description of
the changes.

This version incoporates a lot of changes based on feedback I got
from my previous patch posting on LKML. I would like to thank the reviewers
for their very detailed comments. Through this tough process, I think,
the code overall quality has improved.

Thanks.

--
-Stephane
