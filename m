Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUBVN4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 08:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUBVN4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 08:56:40 -0500
Received: from c251147.customer.hansenet.de ([213.39.251.147]:63189 "EHLO
	sarah.ricardo.de") by vger.kernel.org with ESMTP id S261264AbUBVN4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 08:56:38 -0500
From: Joachim Bremer <joachim.bremer@ricardo.de>
Message-Id: <200402221356.i1MDuadK030840@sarah.ricardo.de>
Subject: 2.6.3-bk-current: early hang ob boot w opteron
To: linux-kernel@vger.kernel.org
Date: Sun, 22 Feb 2004 14:56:36 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL101c (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since the merging of the Intel x86_64 (Patchset 1.1557.62.1) there
is a hang on boot very early if processor family is set to AMD Opteron.
Generic X86_64 and Precott/Nocona works both fine.
The only messages with hang are:

Kernel direct mapping tables upto 10100000000@800-C000
Decompressing Linux...done
Booting the kernel.

That's all.

Machine in question:
Tyan Tiger K8W
Dual Opteron 244 C0-Stepping
1 GByte Ram
Compiler used: GCC 3.3.2, 3.3.3, 3.4.0 pre20040221

Thanks

Joachim
