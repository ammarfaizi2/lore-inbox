Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUIPRgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUIPRgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUIPRgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:36:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20972 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268334AbUIPRfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:35:02 -0400
Date: Thu, 16 Sep 2004 10:34:54 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: ub vs. ubd
Message-Id: <20040916103454.46936a28@lembas.zaitcev.lan>
In-Reply-To: <200409161753.i8GHrM2J003175@ccure.user-mode-linux.org>
References: <1340.1095332981@www10.gmx.net>
	<20040916084118.2441c38a@lembas.zaitcev.lan>
	<200409161753.i8GHrM2J003175@ccure.user-mode-linux.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 13:53:22 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> UML doesn't use uba, it uses ubda.

It looks that the numerical syntax remains in ubd_kern.c in places.
For one, the help for ubd_setup recommends it.

Also, disk->disk_name is done with:
  sprintf(disk->disk_name, "ubd");
Can you send me your /proc/partitions from a guest with a few UBDs
configured?

-- Pete
