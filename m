Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757545AbWK0Je1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545AbWK0Je1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757565AbWK0Je1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:34:27 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:2194 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757545AbWK0Je1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:34:27 -0500
Date: Mon, 27 Nov 2006 10:35:03 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 0/7] Resend(2): driver core patches
Message-ID: <20061127103503.045b3518@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

this is a resend of the driver core patch collection I already sent on
Oct 27. The patches are diffed against 2.6.19-rc6-mm1.

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
