Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVLEBXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVLEBXP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 20:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVLEBXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 20:23:14 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:32128 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1751099AbVLEBXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 20:23:14 -0500
Message-Id: <200512042102.jB4L1vUI016069@pincoya.inf.utfsm.cl>
To: Lee Revell <rlrevell@joe-job.com>
cc: Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo 
In-Reply-To: Message from Lee Revell <rlrevell@joe-job.com> 
   of "Sun, 04 Dec 2005 14:49:26 CDT." <1133725767.19768.12.camel@mindpipe> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 04 Dec 2005 18:01:57 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:

[...]

> Wrong, lots of userspace programs that need to know the CPU speed get it
> from /proc/cpuinfo.  It would be nice if there were a better API.

Why would a /user/ program need to know what the CPU speed is?

In any case, /proc is not the place for this, as it has nothing to do with
processes.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

