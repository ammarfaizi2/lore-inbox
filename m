Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbTLWMsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 07:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTLWMsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 07:48:16 -0500
Received: from [66.98.192.92] ([66.98.192.92]:47081 "EHLO svr44.ehostpros.com")
	by vger.kernel.org with ESMTP id S265126AbTLWMsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 07:48:14 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: linux-kernel@vger.kernel.org
Subject: KGDB: automatic loading of modules in gdb
Date: Tue, 23 Dec 2003 18:18:02 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231818.03072.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have integrated a couple of kgdb features from TimeSys Linux distribution.

1.  Automatic loading of module files in gdb:
A special version of gdb is provided with this feature. It can detect loading 
and unloading of modules in a kernel. Whenever a module is loaded, gdb loads 
the module object file and makes it available for debugging. loadmodule.sh 
script is no longer needed.

2. Better kernel stack traces:
Kernel stack traces stop at entry points into the kernel and few invalid stack 
frames appear in gdb kernel backtraces, if any.

These features are available in kgdb-1.9 at http://kgdb.sourceforge.net

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

