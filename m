Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTCEXek>; Wed, 5 Mar 2003 18:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTCEXek>; Wed, 5 Mar 2003 18:34:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266948AbTCEXeh>;
	Wed, 5 Mar 2003 18:34:37 -0500
Subject: Re: Linux 2.5.64
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046908165.31392.82.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 05 Mar 2003 15:49:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.64

Warnings in an allmodconfig (modules build) went down by 70 and there
were 30 fewer errors in the build.  Kernel build changes and bug fixes
get the credit for this positive movement.

                               2.5.63               2.5.64
                       --------------------    -----------------
bzImage (defconfig)         15 warnings          14 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      29 warnings          30 warnings
                             9 errors             6 errors

modules (allmodconfig)    2426 warnings        2356 warnings
                           128 errors            99 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.64
at: www.osdl.org/archive/cherry/stability



Other links:
   Nightly linux-2.5 bk build:
       www.osdl.org/archive/cherry/stability/linus-tree/running.txt
   2.5 porting items:
       www.osdl.org/archive/cherry/stability/linus-tree/port_items.txt
   2.5 porting items history:
       www.osdl.org/archive/cherry/stability/linus-tree/port_history.txt



A summary of the porting items from the 2.5.64 kernel compile is:

  MCA legacy (move driver to new sysfs API): 27 places
  Misc porting reminders: 20 reminders
  Documentation conversions to Documnentation/DMA-mapping.txt: 7 files
  Other #error conversions: 1 files
  __check_region deprecations: 90 files

  Module use count changes:
     _MOD_INC_USE_COUNT deprecations: 291 files
     _MOD_DEC_USE_COUNT deprecations: 252 files


John

