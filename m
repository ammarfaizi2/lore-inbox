Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUFXOoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUFXOoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbUFXOoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:44:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52954 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264731AbUFXOoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:44:03 -0400
Date: Thu, 24 Jun 2004 07:43:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.7-mm2 build failure
Message-ID: <1968220000.1088088238@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/node.c: In function `node_read_meminfo':
drivers/base/node.c:56: warning: implicit declaration of function `hugetlb_report_node_meminfo'
drivers/built-in.o(.text+0x1f615): In function `node_read_meminfo':
: undefined reference to `hugetlb_report_node_meminfo'
make: *** [.tmp_vmlinux1] Error 1

Hmmm. I wonder if anyone tested that patch ;-)

M.

