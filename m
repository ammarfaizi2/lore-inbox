Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbTLIIbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbTLIIbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:31:18 -0500
Received: from [66.98.192.92] ([66.98.192.92]:58006 "EHLO svr44.ehostpros.com")
	by vger.kernel.org with ESMTP id S266142AbTLIIbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:31:14 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: linux-kernel@vger.kernel.org
Subject: kgdb 1.7
Date: Tue, 9 Dec 2003 14:00:45 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091400.45531.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have integrated some of the several enhancements submitted by TimeSys 
Corporation into mainline kgdb at http://kgdb.sourceforge.net/ The kgdb 
version containing these features is 1.7. It's available for kernel 2.4.23. 
Here is a brief description of the enhancements.

1. Hasslefree gdb detach reconnect:
You can now detach gdb from a kgdb stub by using gdb "detach" command. 
Reconnection later is as simple as typing "target remote" command from gdb.

2. Restructured source files:
Several kgdb source files have been restructured to separate architecture 
dependent and independent code into respective directories. It's a move 
towards making unification of kgdb sourcecode from different architectures.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

