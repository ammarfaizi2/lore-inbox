Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbTH2WfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTH2WfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 18:35:18 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:49636 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S261929AbTH2WfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 18:35:13 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Kenneth Johansson <ken@kenjo.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Content-Type: text/plain
Message-Id: <1062196509.1577.3.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 30 Aug 2003 00:35:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 07:35, Jamie Lokier wrote:
> Dear All,
> 
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.

Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
 
real    0m0.473s
user    0m0.280s
sys     0m0.100s

>cat /proc/cpuinfo
cpu             : 405CR
clock           : 200MHz
revision        : 1.69 (pvr 4011 0145)
bogomips        : 199.88
machine         : Ericsson ELN 2XX
plb bus clock   : 100MHz




