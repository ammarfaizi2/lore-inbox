Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWC2XXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWC2XXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWC2XXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:23:49 -0500
Received: from mx.pathscale.com ([64.160.42.68]:16072 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751242AbWC2XXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:23:49 -0500
Content-Type: multipart/mixed; boundary="===============1103999998=="
MIME-Version: 1.0
Subject: [PATCH 0 of 16] ipath - driver submission for 2.6.17
Message-Id: <patchbomb.1143674603@chalcedony.internal.keyresearch.com>
Date: Wed, 29 Mar 2006 15:23:23 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============1103999998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is a submission of the ipath driver for inclusion in 2.6.17.
Roland, if this looks good to you, please apply.

Changes since the last round of review comments from Roland:

- Support for PathScale userland SMA dropped

- Passes sparse with CF=-D__CHECK_ENDIAN__

- Builds cleanly on ia64

- A few other little fixes here and there

If you have any comments or suggestions, please let me know.

The ipath driver is a driver for PathScale InfiniPath host channel
adapters (HCAs) based on the HT-400 and PE-800 chips, including the
InfiniPath HT-460, the small form factor InfiniPath HT-460, the InfiniPath
HT-470 and the Linux Networx LS/X.

The core driver manages the hardware, and provides a fast memory-mapped
interface to the hardware for userspace networking applications.
Our implementation of the Infiniband protocols and integration into the
kernel's Infiniband stack is written as a layer on top of the core driver.

--===============1103999998==--
