Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263339AbTCSWgn>; Wed, 19 Mar 2003 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbTCSWgn>; Wed, 19 Mar 2003 17:36:43 -0500
Received: from eldar.tcsn.co.za ([196.41.199.50]:54800 "EHLO tcsn.co.za")
	by vger.kernel.org with ESMTP id <S263339AbTCSWgl>;
	Wed, 19 Mar 2003 17:36:41 -0500
Date: Thu, 20 Mar 2003 00:46:53 +0200
From: Henti Smith <bain@tcsn.co.za>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Hard lock with Kernel 2.5.64-2.5.65-mm1 starting XFree 4.3.0
Message-Id: <20030320004653.2deab72b.bain@tcsn.co.za>
Organization: The Computer Smith Networks
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all :) 

Got a hardlock starting XFree 4.3.0 with ATI Technologies Inc Rage 128 Pro Ultra TF

Working config

I have DRI enabled in kernel as well as in XF86Config.
using r128 driver for X

I can enable GLX in XF86Config in 2.4.20 kernel.
(gentoo-sources) 

Broken config (reproducable everytime)

I have DRI enabled in kernel as DRI and GLX as in XF86Config.
using r128 driver for X

X starts up with mouse cursor garbage at the top and system is dead.
not even reset button works.

here is some system information

CHOST="i686-pc-linux-gnu"
CFLAGS="-O2 -mcpu=i686 -pipe"
CXXFLAGS="-O2 -mcpu=i686 -pipe"
MAKEOPTS="-j2"
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)
GNU ld version 2.13.90.0.18 20030121

I also found that when starting XFree86 as root it corrupts my ~/.viminfo file with data, not 100% sure if it's because of the 
crahs but will check it out. nothing in logs.

not sure what else I can tell you so please ask if you need more information.

Henti Smith 
