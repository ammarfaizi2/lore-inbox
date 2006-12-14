Return-Path: <linux-kernel-owner+w=401wt.eu-S1751923AbWLNBGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWLNBGa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWLNBGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:06:30 -0500
Received: from ns.suse.de ([195.135.220.2]:38638 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbWLNBG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:06:29 -0500
Date: Wed, 13 Dec 2006 17:06:08 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de
Subject: Userspace I/O driver core
Message-ID: <20061214010608.GA13229@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A large number of people have expressed interest recently in the
userspace i/o driver core which allows userspace drivers to be written
to handle some types of hardware.

Right now the UIO core is working and in the -mm releases.  It's been
rewritten from the last time patches were posted to lkml and is much
simpler.  It also includes full documentation and two example drivers
and two example userspace programs that test those drivers.

But in order to get this core into the kernel tree, we need to have some
"real" drivers written that use it.  So, for anyone that wants to see
this go into the tree, now is the time to step forward and post your
patches for hardware that this kind of driver interface is needed.

If no such drivers appear, then there is a very slim chance that this
interface will be accepted into the tree.

The patches can be found in the -mm releases or at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio.patch
    - UIO core
  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-documentation.patch
    - UIO documentation
  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-dummy.patch
  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-irq.patch
    - two example kernel modules and userspace programs showing how to
      use the UIO interface.

If anyone has any questions on how to use this interface, or anything
else about it, please let me and Thomas know.

thanks,

greg k-h


