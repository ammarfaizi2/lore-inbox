Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTCEWiP>; Wed, 5 Mar 2003 17:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTCEWiP>; Wed, 5 Mar 2003 17:38:15 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:31497 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP
	id <S266292AbTCEWiO>; Wed, 5 Mar 2003 17:38:14 -0500
Message-ID: <3E667068.4000204@torque.net>
Date: Thu, 06 Mar 2003 08:47:20 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: sysfs mount point permissions in 2.5.64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lk 2.5.64 on my i386 box the sysfs mount point
( "/sys") changes permission from:
   drwxr-xr-x
to
   drw-r--r--
during the boot process. I didn't notice this feature
in lk 2.5.63 . Chmodding the directory back to its former
permissions get overridden by subsequent boot sequences.

This change in permissions inhibits non-root users from using
utilities that scan sysfs for information (e.g. lsscsi).

Is this a feature or otherwise?

Doug Gilbert

