Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUD3Ddv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUD3Ddv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 23:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265050AbUD3Ddv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 23:33:51 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:32655 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265041AbUD3Ddt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 23:33:49 -0400
Subject: Re: Patch for 2.6.x: Add procps URL to Doc/Changes
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rddunlap@osdl.org, rich@phekda.gotadsl.co.uk
Content-Type: text/plain
Organization: 
Message-Id: <1083287510.3450.1082.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Apr 2004 21:11:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:

> alternative: ??

No, not if you want your procps to work anyway.

If your TTY is pts/256 or above, you'll need
procps-3.2.0 or above to see it and select it.

If you think "ps s" shouldn't be missing a few
columns, procps-3.1.6 or above is needed.

If you want to view threads, procps-3.1.14 or
above is needed.

If you want to run SE Linux, procps-3.1.15 or
above is needed.

------------- partial list of improvements --------------
* ps fully supports thread display (H, -L, m, -m, and -T)
* ps can display NSA SELinux security contexts
* top can show CPU usage for IO-wait, IRQ, and softirq
* can set $PS_FORMAT to choose your own default ps format
* better width control ("ps -o pid,wchan:42,args")
* width of ps PID column adjusts to your system
* vmstat lets you choose units you like: 1000, 1024, 1000000...
* top can sort by any column (old sort keys available too)
* top can select a single user to display
* top can be put in multi-window mode and/or color mode
* vmstat has the -s option, as found on UNIX and BSD systems
* vmstat has the -f option, as found on UNIX and BSD systems
* watch doesn't eat the first blank line by mistake
* vmstat uses a fast O(1) algorithm on 2.5.xx kernels
* pmap command is SunOS-compatible
* vmstat shows IO-wait time
* pgrep and pkill can find the oldest matching process
* sysctl handles the Linux 2.5.xx VLAN interfaces
* ps has a new "-F" format (very nice, like DYNIX/ptx has)
* ps with proper BSD process selection
* better handling of very long uptimes


