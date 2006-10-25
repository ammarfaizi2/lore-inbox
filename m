Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWJYTPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWJYTPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWJYTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:15:49 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:21128 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S964798AbWJYTPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:15:48 -0400
Date: Wed, 25 Oct 2006 20:15:47 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] intelfb patches for 2.6.19-rc3 (corrected)
Message-ID: <Pine.LNX.4.64.0610252014160.9796@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sorry the PM talk distracted me while writing this last-time..)
Hi Linus,

Can you pull the 'intelfb-patches' from
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6 intelfb-patches

This is just some minor fixes to intelfb...

Regards,
Dave.

  drivers/video/intelfb/intelfbhw.c |    6 ++++--
  1 files changed, 4 insertions(+), 2 deletions(-)

commit f84fcb06a1f7ab4ac0444ece82b25b0701369641
Author: Eric Sesterhenn <snakebyte@gmx.de>
Date:   Fri Oct 20 14:35:59 2006 -0700

     Remove unnecessary check in drivers/video/intelfb/intelfbhw.c

     All callers and the function itself dereference dinfo, so we can remove the
     check.  (coverity id #1371)

     Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit a77b8950019289611f836c8fc19f91592822efcd
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Fri Oct 20 14:36:00 2006 -0700

     intel fb: switch to pci_get API

     Signed-off-by: Alan Cox <alan@redhat.com>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>
