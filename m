Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVCNVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVCNVPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCNVPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:15:05 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55786 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261908AbVCNVPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:15:00 -0500
Subject: [PATCH 0/4] sparsemem intro patches
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 13:14:43 -0800
Message-Id: <1110834883.19340.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following four patches provide the last needed changes before the
introduction of sparsemem.  For a more complete description of what this
will do, please see this patch:

http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-150-sparsemem.patch

or previous posts on the subject:
http://marc.theaimsgroup.com/?t=110868540700001&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-mm&m=109897373315016&w=2

Three of these are i386-only, but one of them reorganizes the macros
used to manage the space in page->flags, and will affect all platforms.
There are analogous patches to the i386 ones for ppc64, ia64, and
x86_64, but those will be submitted by the normal arch maintainers.

The combination of the four patches has been test-booted on a variety of
i386 hardware, and compiled for ppc64, i386, and x86-64 with about 17
different .configs.  It's also been runtime-tested on ia64 configs (with
more patches on top).

-- Dave

