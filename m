Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317935AbSHCWsT>; Sat, 3 Aug 2002 18:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318024AbSHCWsT>; Sat, 3 Aug 2002 18:48:19 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:32967 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S317935AbSHCWsS>; Sat, 3 Aug 2002 18:48:18 -0400
Message-Id: <200208032300.g73N0Pix000183@pool-141-150-241-241.delv.east.verizon.net>
Date: Sat, 3 Aug 2002 19:00:21 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.30 LILO FreeBSD partition problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running 2.5.30 I receive this error when running LILO with a
FreeBSD partition in lilo.conf

  Device 0x0300: Invalid partition table, 3rd entry
    3D address:     1/0/530 (534240)
    Linear address: 1/14/8446 (8514450)

I removed the fbsd entry and LILO had no problems.  I then booted
to 2.4 and readded the fbsd partition and it installed fine.

The problem seems similar to what Ingo reported for 2.5.29 however on my
system the only problem is the freebsd partition.  Also, 2.5.29 worked
fine for me.

-- 
Skip
