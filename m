Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135516AbRDZPYd>; Thu, 26 Apr 2001 11:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135520AbRDZPYX>; Thu, 26 Apr 2001 11:24:23 -0400
Received: from vs-01.stealthwave.net ([208.205.224.43]:58636 "EHLO
	digital-mission.com") by vger.kernel.org with ESMTP
	id <S135516AbRDZPYH>; Thu, 26 Apr 2001 11:24:07 -0400
Date: Thu, 26 Apr 2001 11:24:06 -0400 (EDT)
From: Robert Dale <rdale@digital-mission.com>
To: linux-kernel@vger.kernel.org
Subject: rewrote datastructures using pgsql (was Re: /proc format (was Device
 Registry (DevReg) Patch 0.2.0))
Message-ID: <Pine.LNX.4.10.10104261117360.22000-100000@vs-01.digipath.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I finished porting all the kernel data structures to embedded postgresql.
Instead of doing 'cat /proc/cpuinfo', you now can do
  'echo "select * from cpuinfo,cpuinfo_flags where
  cpuinfo.processor=cpuinfo_flags.processor" > /proc/sql'.
No more worries about silly /proc format issues.  Patch coming shortly.

-- 
Robert Dale


