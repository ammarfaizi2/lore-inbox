Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUDAIuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbUDAIuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:50:22 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:53120 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262784AbUDAIuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:50:18 -0500
Date: Thu, 1 Apr 2004 00:49:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, colpatch@us.ibm.com,
       Hariprasad Nellitheertha <hari@in.ibm.com>
Subject: Re: [PATCH] mask ADT: simplify a couple cpumask uses [8/22]
Message-Id: <20040401004900.1ba8c532.pj@sgi.com>
In-Reply-To: <20040329041315.765d4dd2.pj@sgi.com>
References: <20040329041315.765d4dd2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to drop the cpumask_t refinements in this Patch to the files:

  arch/i386/kernel/smp.c
  arch/x86_64/kernel/smp.c

A gentleman named "Hari" (Hariprasad Nellitheertha <hari@in.ibm.com>) on
the thread "BUG_ON(!cpus_equal(cpumask, tmp));" is working more
essential changes to these same lines.  No sense my colliding with him;
and if his changes go in, mine are no longer relevant.

So I will clear the path for his work.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
