Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTJBUpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 16:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbTJBUpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 16:45:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:34227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263479AbTJBUpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 16:45:15 -0400
Date: Thu, 2 Oct 2003 13:45:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test6-mm2
Message-ID: <20031002134504.A12141@osdlab.pdx.osdl.net>
References: <20031002022341.797361bc.akpm@osdl.org> <20031002223545.55611ef6.bonganilinux@mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031002223545.55611ef6.bonganilinux@mweb.co.za>; from bonganilinux@mweb.co.za on Thu, Oct 02, 2003 at 10:35:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bongani Hlope (bonganilinux@mweb.co.za) wrote:
> -mm1 had a lot of events/0 zombies, and vanilla 2.6.0-test6 does not. I will test -mm2 and let you know how it goes. Alt-SysRq shows this:
> 
> 
> events/0      Z 77361907  1834      3          1836  1831 (L-TLB)
> c46abfc4 00000046 cf901940 77361907 00000058 c5dfa080 00000011 77361907
>        00000058 cf901940 cf901960 00011d32 77361907 00000058 cffeeaf8 00000000
>        c5dfa080 00000000 c0124b60 c5dfa080 00000000 00000000 00000000 c01322f0
> Call Trace:
>  [do_exit+560/1040] do_exit+0x230/0x410
>  [<c0124b60>] do_exit+0x230/0x410
>  [wait_for_helper+0/224] wait_for_helper+0x0/0xe0
>  [<c01322f0>] wait_for_helper+0x0/0xe0
>  [kernel_thread_helper+11/12] kernel_thread_helper+0xb/0xc
>  [<c010ae5f>] kernel_thread_helper+0xb/0xc

Just to be clear, this sysrq trace is from -mm1, correct?  A fix has
gone into -mm2 for this, which is why I'm asking.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
