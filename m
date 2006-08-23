Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWHWIPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWHWIPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWHWIPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:15:55 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:50393 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932382AbWHWIPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:15:54 -0400
Date: Wed, 23 Aug 2006 01:05:52 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230805.k7N85qo2000348@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series of patches includes the generic perfmon2
subsystem and the support for i386, x86_64, and powerpc. The perfmon2
subsystem also works on MIPS and all Itanium processors. The Itanium support
is not posted because it does not easily accomodate the 100k message
limit of lkml. The powerpc support is still very preliminary.

The patches are relative to 2.6.17.9

I have already posted on the list about this subsystem. I am submitting 
today to get reviews and make progress towards getting the subsystem
merged into the mainline kernel.

The patches are split up between common and arch-specific. Each part
is further decomposed into new files and modified files. The generic
code is now split up by functionality to make reading easier.

For each new or modified files, I provide a detailed description of
the changes in each E-mail.

Thanks.

--
-Stephane
