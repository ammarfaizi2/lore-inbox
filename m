Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUDSJMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUDSJMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:12:49 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:23055 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264363AbUDSJMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:12:47 -0400
Message-ID: <40839850.2010907@aitel.hist.no>
Date: Mon, 19 Apr 2004 11:13:52 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1 failure: kmod.o didn't compile with module-less
 setup
References: <20040418230131.285aa8ae.akpm@osdl.org>
In-Reply-To: <20040418230131.285aa8ae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one zonked out. I haven't configured module support, I simply
compile a monolithic kernel tailored for this particular machine.
I got this error, where 2.6.5-mm6 works well:

  CC      kernel/kmod.o
kernel/kmod.c: In function `call_usermodehelper':
kernel/kmod.c:253: error: `khelper_wq' undeclared (first use in this function)
kernel/kmod.c:253: error: (Each undeclared identifier is reported only once
kernel/kmod.c:253: error: for each function it appears in.)
kernel/kmod.c: In function `usermodehelper_init':
kernel/kmod.c:267: error: `khelper_wq' undeclared (first use in this function)
make[1]: *** [kernel/kmod.o] Error 1
make: *** [kernel] Error 2

Helge Hafting

