Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbVKQAlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbVKQAlc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbVKQAlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:41:32 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:404 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161046AbVKQAlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:41:31 -0500
Subject: 2.6.15-rc1-git4 build failure on ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Anton Blanchard <anton@samba.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:41:24 -0800
Message-Id: <1132188084.24066.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I get following compile error on PPC64 - while trying to compile
CONFIG_FLATMEM=y. 

arch/powerpc/mm/numa.c: In function `dump_numa_topology':
arch/powerpc/mm/numa.c:516: error: `SECTION_SIZE_BITS' undeclared (first
use in this function)
arch/powerpc/mm/numa.c:516: error: (Each undeclared identifier is
reported only once
arch/powerpc/mm/numa.c:516: error: for each function it appears in.)
make[1]: *** [arch/powerpc/mm/numa.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/powerpc/mm] Error 2


Thanks,
Badari

