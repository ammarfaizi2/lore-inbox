Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUDTAEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUDTAEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUDTAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:04:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:3558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261351AbUDTAEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:04:32 -0400
Date: Mon, 19 Apr 2004 17:04:31 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: <linux-kernel@vger.kernel.org>
cc: <plm-devel@lists.sourceforge.net>
Subject: OSDL-PLM kernel Cross Compiles-sparc, sparc64, alpha
Message-ID: <Pine.LNX.4.33.0404191458070.15648-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some interest has been expressed in seeing more extensive
cross compiler tool chains in OSDL's automated testing environment,
so building can be checked for some of the platforms that aren't
commonly tested on (i.e., non-x86 platforms.)

We've added three new tool chains to the Patch Lifecycle Manager for
cross compiling on Alpha, Sparc, and Sparc64, adding to the existing
cross compilers for PPC, and ia64.  These are used in PLM to
indicate build success/fail on these platforms for individual patches
through error and warning counts on defconfig.  For example,
see results (2.6.6-rc1-mm1 and linux-2.6.6-rc1-bk4 respectively) at:
    http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=2895
    http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=2896

or any of the kernels added since last friday.


The cross compilers were built on ia32 using Dan Kegel's 'crosstool-0.27'.
You can download them to produce specific error messages and play with
the results at this address:

    http://developer.osdl.org/dev/plm/cross_compile/

They are currently compressed tar files.  Please let me know if you run
into any issues or have questions.


Judith Lebzelter

Test & Performance
OSDL




