Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318448AbSGZToJ>; Fri, 26 Jul 2002 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSGZToJ>; Fri, 26 Jul 2002 15:44:09 -0400
Received: from holomorphy.com ([66.224.33.161]:49311 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318448AbSGZToI>;
	Fri, 26 Jul 2002 15:44:08 -0400
Date: Fri, 26 Jul 2002 12:46:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>, riel@conectiva.com.br,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020726194643.GX2907@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
	riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
References: <20020726204033.D18570@in.ibm.com> <3D41990A.EDC1A530@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D41990A.EDC1A530@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 11:46:34AM -0700, Andrew Morton wrote:
> Oh dear.  Most people only have two CPUs.
> Rusty, can we *please* fix this?  Really soon?

I'll post the panic triggered by lowering NR_CPUS shortly. There's
an ugly showstopping i386 arch code issue here.


Cheers,
Bill
