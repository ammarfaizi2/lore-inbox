Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUAQJWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 04:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUAQJWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 04:22:19 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:43688 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266004AbUAQJWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 04:22:18 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: kgdb 2.0.4 with restructuring and fixes
Date: Sat, 17 Jan 2004 14:51:38 +0530
User-Agent: KMail/1.5
Cc: "Steve Gonczi" <steve@relicore.com>, Matt Mackall <mpm@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171451.38701.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kgdb 2.0.4 is available at http://kgdb.sourceforge.net ChangeLog below.
Thanks.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)


2004-01-17 Tom Rini <trini@kernel.crashing.org>
	* Some restructuring to allow architectures to provide different
	serial infos to the kgdb serial interface.

2004-01-17 Pavel Machek <pavel@suse.cz>
	* Cleanups
	* changed calling convention from 0 on success, 1 on failure to 0 on
	success, -ERRNO on fail to be more consistent with rest of kernel
	* Made kgdb waiting for connection message KERN_CRIT
	* export kern_schedule only if CONFIG_KGDB_THREAD is defined



