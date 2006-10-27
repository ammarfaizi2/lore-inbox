Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946422AbWJ0LgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946422AbWJ0LgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946424AbWJ0LgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:36:12 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:33838 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946422AbWJ0LgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:36:12 -0400
Date: Fri, 27 Oct 2006 13:36:47 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [Patch 0/7] Resend: driver core patches
Message-ID: <20061027133647.1eb5e389@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

here's a rediff of some driver core patches I send before against your
current tree (patches in driver/ applied). Patches 1-3 had been sitting
in -mm for a while, patches 4-7 have already been sent on Oct 17.

[1/7] driver core fixes: make_class_name() retval checks
[2/7] driver core fixes: sysfs_create_link() retval checks in core.c
[3/7] driver core fixes: device_register() retval check in platform.c
[4/7] driver core: Don't stop probing on ->probe errors.
[5/7] driver core: Change function call order in device_bind_driver().
[6/7] driver core: Per-subsystem multithreaded probing.
[7/7] driver core: Don't fail attaching the device if it cannot be bound.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
