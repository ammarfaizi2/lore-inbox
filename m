Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265594AbUFDEmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUFDEmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUFDEmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:42:03 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:51295 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265603AbUFDEl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:41:57 -0400
Date: Thu, 3 Jun 2004 21:51:00 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] cpumask 10/10 optimize various uses of new cpumasks
Message-Id: <20040603215100.78ceb511.pj@sgi.com>
In-Reply-To: <1086323259.29381.1036.camel@bach>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101115.7f746d98.pj@sgi.com>
	<1086323259.29381.1036.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This means we can finally do this, too... Yes!

Nice.  Though, actually, I suspect that Linus deserves the
credit for this particular improvement.  He suggested adding
a (cpumask_t) typecast to the CPU_MASK_ALL macro, just for
this reason.

Or at least that's my recollection.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
