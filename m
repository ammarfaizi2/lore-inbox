Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264807AbUDWNuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264807AbUDWNuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264811AbUDWNuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:50:55 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:55219 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S264807AbUDWNux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:50:53 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01E2576A@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'Anton Altaparmakov'" <aia21@cam.ac.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [OFFTOPIC] 2.6.4v SFS instead of NTFS mp
Date: Fri, 23 Apr 2004 15:50:50 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton,

	Working with the following config

	hda : dos partitioning
	hdb : ldm

	When plugging LDM in both 2.6.4 & 2.6.5 I have VFS unable to mount
the /dev/hda7 original root device.
(This won't happen just before building both kernels without that support
...)

If I diff configs with/out advanced partition selection:

Without :
CONFIG_MSDOS_PARTITION=y
With:
-CONFIG_MSDOS_PARTITION=y
+CONFIG_PARTITION_ADVANCED=y

Does it mean I can't work in hybrid mode ?

Regards,
Fabian
