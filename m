Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422627AbWCXElv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbWCXElv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 23:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423007AbWCXElv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 23:41:51 -0500
Received: from mx.pathscale.com ([64.160.42.68]:18923 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422627AbWCXElu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 23:41:50 -0500
Content-Type: multipart/mixed; boundary="===============0073920395=="
MIME-Version: 1.0
Subject: [PATCH 0 of 18] ipath driver - for inclusion in 2.6.17
Message-Id: <patchbomb.1143175292@eng-12.pathscale.com>
Date: Thu, 23 Mar 2006 20:41:32 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, greg@kroah.com, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0073920395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi -

This is a submission of the ipath driver for inclusion in 2.6.17.
Andrew, if this looks good to you, please apply.

We have addressed all earlier rounds of feedback; the driver is stable;
it compiles with no compiler or sparse warnings against current -git (it's
comprehensively annotated for sparse); and I think it's in good shape.
We have gone to great lengths over the past several months to make it
an exemplary kernel citizen.

Changes since the last round of review comments:

  - We have rewritten some code in ipath_rc.c to make it more
    comprehensible and maintainable.

  - The ipathfs filesystem now handles hotplugged devices.

  - Miscellaneous fixes requested by Greg and Andrew.

If you have any comments or suggestions, please let me know.

The ipath driver is a driver for PathScale InfiniPath host channel
adapters (HCAs) based on the HT-400 and PE-800 chips, including the
InfiniPath HT-460, the small form factor InfiniPath HT-460, the InfiniPath
HT-470 and the Linux Networx LS/X.

The core driver manages the hardware, and provides a fast memory-mapped
interface to the hardware for userspace networking applications.
Our implementation of the Infiniband protocols and integration into the
kernel's Infiniband stack is written as a layer on top of the core driver.

	<b

--===============0073920395==--
