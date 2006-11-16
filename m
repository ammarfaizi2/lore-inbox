Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424102AbWKPOlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424102AbWKPOlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424103AbWKPOlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:41:31 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:51295 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1424102AbWKPOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:41:31 -0500
Date: Thu, 16 Nov 2006 15:42:04 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg K-H <greg@kroah.com>,
       Kay Sievers <kay.sievers@vrfy.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [Patch -mm 0/2]driver core: Infrastructure for device moving.
Message-ID: <20061116154204.1a3cac21@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a basically a resend of the driver core patches I already sent
on Nov 14. (They are needed as a base for the s390 cio patches of that
patchset which still are in -mm.)

Patch 1 is unchanged, patch 2 now also contains the KOBJ_MOVE uevent
which will be generated when a kobject has been moved (and a small fix
for !CONFIG_SYSFS).

[1/2] Introduce device_find_child().
[2/2] Introduce device_move(): move a device to a new parent.

Patches are again against 2.6.19-rc5-mm2.
