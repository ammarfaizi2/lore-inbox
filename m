Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbUKCRJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUKCRJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbUKCRI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:08:57 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:8199 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261739AbUKCRI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:08:29 -0500
Message-ID: <4189108C.2050804@blueyonder.co.uk>
Date: Wed, 03 Nov 2004 17:08:28 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2004 17:08:55.0722 (UTC) FILETIME=[CD1ED8A0:01C4C1C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CHK     include/linux/version.h
   UPD     include/linux/version.h
   SYMLINK include/asm -> include/asm-x86_64
scripts/kconfig/conf -s arch/x86_64/Kconfig
#
# using defaults found in .config
#
   SPLIT   include/linux/autoconf.h -> include/config/*
   CC      /usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.s
In file included from include/asm/timex.h:12,
                  from include/linux/timex.h:61,
                  from include/linux/sched.h:11,
                  from 
/usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.c:7:
include/asm/vsyscall.h:55: error: conflicting types for `xtime_lock'
include/linux/time.h:83: error: previous declaration of `xtime_lock'
make[1]: *** 
[/usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.s] Error 1
make: *** [prepare0] Error 2

Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
