Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVJZNz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVJZNz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 09:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVJZNz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 09:55:29 -0400
Received: from bromo.msbb.uc.edu ([129.137.3.146]:21683 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S1751493AbVJZNz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 09:55:29 -0400
To: linux-kernel@vger.kernel.org
Subject: PCI error on x86_64 2.6.13 kernel
Message-Id: <20051026135358.2CE3A1DC06D@bromo.msbb.uc.edu>
Date: Wed, 26 Oct 2005 09:53:58 -0400 (EDT)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Has anyone reported the following? For both of the 2.6.13 based
kernels released so far on Fedora Core 4 for x86_64, we are seeing
error messages of the form...

Oct  3 11:21:48 XXXXX  kernel:   MEM window: d0200000-d02fffff
Oct  3 11:21:48 XXXXX  kernel:   PREFETCH window: disabled.
Oct  3 11:21:48 XXXXX  kernel: PCI: Failed to allocate mem resource #6:20000 f0000000 for 0000:09:00.0

...on a Sun W2100Z dual opteron. These memory allocations errors 
don't occur under the 2.6.12 based kernels that Fedora has released 
for FC4. So far the errors don't seem to be manifesting themselves 
as any noticable system errors in using the machine itself.
                    Jack
