Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVFLLQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVFLLQz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVFLLQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:16:54 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15075 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261935AbVFLLQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:16:41 -0400
Date: Sun, 12 Jun 2005 13:16:19 +0200 (MEST)
Message-Id: <200506121116.j5CBGJPs019683@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 0/9] gcc4 fixes overview
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches fixes gcc4 problems in the 2.4.31
kernel's 'core' code. I've been running gcc4-compiled 2.4
kernels for several months on i386, x86_64, and ppc32, and
there are currently no known regressions compared to gcc34.

Note: you'll want to use recent gcc-4.0.1 snapshots as
gcc-4.0.0 is known to be broken.

This set of patches do not include fixes to drivers,
file systems, or architectures I don't use myself. I
have a preliminary patch kit for those, but as it
has received only limited compile testing I'm not
submitting it unless these core patches are accepted.

The patch set consists of the following 9 parts:
[1/9] fix incomplete array errors
[2/9] fix static-vs-nonstatic redefinition errors
[3/9] fix nested function declaration errors
[4/9] fix undefined strcpy linkage errors
[5/9] fix x86_64 acpi assembly error
[6/9] fix x86_64 sys_iopl() bug
[7/9] fix const function warnings
[8/9] silence pointer signedness warnings
[9/9] fix i386 struct_cpy() warnings

/Mikael
