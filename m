Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313289AbSDDSGv>; Thu, 4 Apr 2002 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313297AbSDDSGl>; Thu, 4 Apr 2002 13:06:41 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59255 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313289AbSDDSG3>; Thu, 4 Apr 2002 13:06:29 -0500
Date: Thu, 4 Apr 2002 13:06:26 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Changes in s390x uaccess.h in 2.4.17+
Message-ID: <20020404130626.B2923@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

The 2.4.17 patch comes with a change to uaccess.h, which
contains the following:

- *  These functions have a non-standard call interface
+ *  These functions have standard call interface

Does it look familiar to anyone? The change is in Marcelo's
tree now, but I am curious what it actually does.

The 2.4.17 patch readme says "This patch contains the current
recommended kernel 2.4.7 code base (up to 2002-01-21),
adapted to kernel 2.4.17.", but I cannot find this change
in any published 2.4.7 patches. I am pretty sure there must
be a good reason for the change, and it's interesting to
know what it is.

-- Pete
