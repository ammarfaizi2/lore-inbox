Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUFDFlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUFDFlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUFDFlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:41:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:29365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264256AbUFDFlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:41:16 -0400
Date: Thu, 3 Jun 2004 22:40:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: pj@sgi.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603224033.2dc5da9f.akpm@osdl.org>
In-Reply-To: <40C00A2B.1040606@yahoo.com.au>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603223005.01bbab21.pj@sgi.com>
	<40C00A2B.1040606@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  Yes, I'm all for the full cpumask abstraction.

Where do we stand wrt pass-by-reference?  I remember there was initially
some concern that lugging 512-bit scalars around by value was expensive, so
Bill's original work was at least geared toward pass-by-reference?

