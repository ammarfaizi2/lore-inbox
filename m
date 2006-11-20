Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756486AbWKTCrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486AbWKTCrl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756594AbWKTCrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:47:41 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:23739 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756486AbWKTCrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:47:40 -0500
Date: Sun, 19 Nov 2006 18:44:37 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rolandd@cisco.com, openib-general@openib.org
Subject: infiniband section mismatches
Message-Id: <20061119184437.2608912c.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.19-rc6-git2:
with CONFIG_HOTPLUG=n:

WARNING: drivers/infiniband/hw/amso1100/iw_c2.o - Section mismatch: reference to .init.text:c2_init_pd_table from .text between 'c2_rnic_init' (at offset 0x25c6) and 'c2_add_addr'
WARNING: drivers/infiniband/hw/amso1100/iw_c2.o - Section mismatch: reference to .init.text:c2_init_qp_table from .text between 'c2_rnic_init' (at offset 0x25d5) and 'c2_add_addr'
WARNING: drivers/infiniband/hw/amso1100/iw_c2.o - Section mismatch: reference to .exit.text:c2_cleanup_qp_table from .text between 'c2_rnic_term' (at offset 0x1e64) and 'c2_del_addr'
WARNING: drivers/infiniband/hw/amso1100/iw_c2.o - Section mismatch: reference to .exit.text:c2_cleanup_pd_table from .text between 'c2_rnic_term' (at offset 0x1e6c) and 'c2_del_addr'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text: from .text between '__mthca_init_one' (at offset 0x69a) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_pd_table from .text between '__mthca_init_one' (at offset 0x77e) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_mr_table from .text between '__mthca_init_one' (at offset 0x7a2) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_eq_table from .text between '__mthca_init_one' (at offset 0x7ff) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_cq_table from .text between '__mthca_init_one' (at offset 0x88f) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_srq_table from .text between '__mthca_init_one' (at offset 0x8b3) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_qp_table from .text between '__mthca_init_one' (at offset 0x8d4) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_av_table from .text between '__mthca_init_one' (at offset 0x8f5) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .init.text:mthca_init_mcg_table from .text between '__mthca_init_one' (at offset 0x916) and '__mthca_restart_one'
WARNING: drivers/infiniband/hw/mthca/ib_mthca.o - Section mismatch: reference to .exit.text:mthca_free_agents from .text between '__mthca_remove_one' (at offset 0x179) and '__mthca_init_one'


---
~Randy
