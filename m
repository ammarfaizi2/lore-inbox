Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWJ2Co5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWJ2Co5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWJ2Co5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:44:57 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60584 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964943AbWJ2Co5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:44:57 -0400
Message-Id: <20061029024504.760769000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Sat, 28 Oct 2006 19:45:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: [PATCH 0/7] x86 paravirtualization infrastructure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches introduce the core infrastructure needed to
paravirtualize the 32-bit x86 Linux kernel.  This is done by moving
virtualization sensitive insn's or code paths to a function table,
paravirt_ops.  This structure can be populated with hypervisor specific
calls or native stubs and currently support running on bare metal, VMI,
Xen, or Lhype.  These patches apply to 2.6.19-rc2-mm2 plus the last set
of paravirt prep patches that Rusty sent.

thanks,
-chris
--
