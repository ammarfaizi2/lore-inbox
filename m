Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261494AbSIZUuD>; Thu, 26 Sep 2002 16:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSIZUuC>; Thu, 26 Sep 2002 16:50:02 -0400
Received: from ext-ch1gw-3.online-age.net ([216.34.191.37]:3540 "EHLO
	ext-ch1gw-3.online-age.net") by vger.kernel.org with ESMTP
	id <S261494AbSIZUuC>; Thu, 26 Sep 2002 16:50:02 -0400
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC14D6@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Distributing drivers independent of the kernel source tree
Date: Thu, 26 Sep 2002 16:55:07 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some time I have been trying to figure out how to distribute drivers
that are not part of the kernel source tree. The drivers that I am supplying
are open source (BSD license) but are for obscure hardware and/or not ready
for/may never be ready for inclusion in the kernel proper. Business being
what it is though, I have to get them to the customer yesterday.

I would like to know if there is a good way to distribute drivers separate
from the kernel source tree?  

1. Supplying patches does not seem to be feasible because there are so many
kernel versions and trees to cover. I'm not in a position to tell my
customers to run version 2.4.xx-xx. They need to be able to use these
drivers with the kernel version they have in their production environment.
Instead, I try to make my driver work on all versions of kernel 2.4.x.

2. Assuming the kernel source is in /usr/src/linux is not always valid.

3. I currently use /usr/src/linux-`uname -r` to locate the kernel source
which is just as broken as method #2.

If no good method exists, would someone be willing to suggest a standard
which would allow distribution of drivers separate from the kernel tree?
