Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUIMQqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUIMQqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUIMQqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:46:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:8914 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268343AbUIMQjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:39:35 -0400
Subject: 2.6.9-rc1-mm5 compile errors
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1095093355.3628.152.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Sep 2004 09:35:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I get following compile errors on PPC64 (P3) box while trying
to build 2.6.9-rc1-mm5.

Are these known/fixed ?

Thanks,
Badari

mm/mempolicy.c: In function `get_zonemask':
mm/mempolicy.c:419: error: `maxnode' undeclared (first use in this
function)
mm/mempolicy.c:419: error: (Each undeclared identifier is reported only
once
mm/mempolicy.c:419: error: for each function it appears in.)
arch/ppc64/kernel/pSeries_pci.c: In function `pcibios_fixup_bus':
arch/ppc64/kernel/pSeries_pci.c:607: error: redeclaration of `dev'
arch/ppc64/kernel/pSeries_pci.c:604: error: `dev' previously declared
here
arch/ppc64/kernel/pSeries_pci.c:604: warning: unused variable `dev'
make[1]: *** [arch/ppc64/kernel/pSeries_pci.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: *** [mm/mempolicy.o] Error 1
make: *** [mm] Error 2
make: *** Waiting for unfinished jobs....
arch/ppc64/kernel/pSeries_htab.c: In function
`pSeries_hpte_updateboltedpp':
arch/ppc64/kernel/pSeries_htab.c:243: warning: `flags' might be used
uninitialized in this function
arch/ppc64/kernel/prom.c: In function `map_interrupt':
arch/ppc64/kernel/prom.c:1808: warning: `newintrc' might be used
uninitialized in this function
arch/ppc64/kernel/prom.c:1808: warning: `newaddrc' might be used
uninitialized in this function


