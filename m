Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSIXAQK>; Mon, 23 Sep 2002 20:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbSIXAQJ>; Mon, 23 Sep 2002 20:16:09 -0400
Received: from holomorphy.com ([66.224.33.161]:1432 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261483AbSIXAQI>;
	Mon, 23 Sep 2002 20:16:08 -0400
Date: Mon, 23 Sep 2002 17:20:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.38 semaphore.c calls sleeping function in illegal context
Message-ID: <20020924002052.GS25605@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.6 on i686 2.5.38-2.  Options used
     -v /mnt/b/2.5.38/vmlinux-2.5.38-2 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.5.38-2 (specified)

Reading Oops report from the terminal
c02c9f6c c02c9f84 c01175f7 c0260f80 c0261500 0000007e c02c9f98 c011a4a1 
       c0261500 0000007e 00000000 c02c9fac c011a78a c0312480 c0278213 c0383244 
       c02c9fb8 c02d8316 c02ba640 c02c9fc0 c02d8164 c02c9fd0 c02d8a4b 00000000 
Call Trace: [<c01175f7>] [<c011a4a1>] [<c011a78a>] [<c0105000>]                
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01175f7 <__might_sleep+27/2b>
Trace; c011a4a1 <acquire_console_sem+2d/50>
Trace; c011a78a <register_console+122/1cc>
Trace; c0105000 <_stext+0/0>


1 warning issued.  Results may not be reliable.
