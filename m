Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTKHAa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTKGWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:06:26 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:50064 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S264611AbTKGTlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 14:41:12 -0500
Message-ID: <1068234006.3fabf5162fd7b@horde.sandall.us>
Date: Fri,  7 Nov 2003 11:40:06 -0800
From: Eric Sandall <eric@sandall.us>
To: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: nforce2 random lockups - still no solution ?
References: <3F95748E.8020202@tuwien.ac.at> <200311060111.06729.vda@port.imtp.ilyichevsk.odessa.ua> <3FAA2653.9020002@tuwien.ac.at>
In-Reply-To: <3FAA2653.9020002@tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 134.121.40.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>:
> It was local APIC ! After recompiling 2.4.22 without local apic 
> everything works smoothly since several  weeks. I wonder when there'll 
> be a kernel
> patch that really solves these nforce2/amd issues.
> Sam

Disabling local APIC on 2.6.0-test9-mm2 also fixes this (I haven't tried on
earlier kernels).

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
