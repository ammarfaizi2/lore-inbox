Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSIKFhw>; Wed, 11 Sep 2002 01:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSIKFhw>; Wed, 11 Sep 2002 01:37:52 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:33526 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318324AbSIKFhv>; Wed, 11 Sep 2002 01:37:51 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15742.55241.543312.523055@wombat.chubb.wattle.id.au>
Date: Wed, 11 Sep 2002 15:42:33 +1000
To: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: /proc/partitions gets name wrong for IDE discs
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The `all of disc' name in /proc/partitions is coming out as `<NULL>'
instead of /dev/hda or similar when not using devfs, in current BK.

major minor  #blocks  name

   9     0  240120512 <NULL>
   3     0    4202415 <NULL>
   3     1     979933 hda1
   3     2     979965 hda2
   3     3    2241067 hda3
  22     0  120060864 <NULL>
  22     1  120059887 hdc1
  22    64  120060864 <NULL>
  22    65  120060830 hdd1



--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
