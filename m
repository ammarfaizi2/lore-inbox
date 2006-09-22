Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWIVJgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWIVJgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWIVJgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:36:25 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:32222 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750876AbWIVJgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:24 -0400
Date: Fri, 22 Sep 2006 11:36:45 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [0/9] driver core fixes, v2
Message-ID: <20060922113645.0846f576@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

this is a rebase (also adressing comments) of the patchset I sent on
Sep 13 against your kernel tree. (If you'd prefer the patches against a
kernel without the class device rework, please let me know.)

 [1/9] driver core fixes: make_class_name() retval check
 [2/9] driver core fixes: device_register() retval check in platform.c
 [3/9] driver core fixes: sysfs_create_link() retval check in class.c
 [4/9] driver core fixes: bus_add_attrs() retval check
 [5/9] driver core fixes: bus_add_device() cleanup on error
 [6/9] driver core fixes: device_add() cleanup on error
 [7/9] driver core fixes: sysfs_create_link() retval check in core.c
 [8/9] driver core fixes: device_create_file() retval check in dmapool.c
 [9/9] driver core fixes: sysfs_create_group() retval in topology.c

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
