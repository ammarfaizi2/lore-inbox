Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUDFHfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbUDFHfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:35:14 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:11916 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263654AbUDFHfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:35:04 -0400
Date: Tue, 6 Apr 2004 00:34:24 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040406003424.75a9b1d3.pj@sgi.com>
In-Reply-To: <40725455.5040407@yahoo.com.au>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
	<20040405230601.62c0b84c.pj@sgi.com>
	<1081233543.15274.190.camel@bach>
	<40725455.5040407@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, responding to Rusty:
> > I certainly don't want
> > to learn 28 nodemask and 28 cpumask primitives.
> > 
> 
> If they are all equivalent operations,

In this case, they are equivalent.   The nodemask.h header in this patch
series is very close to being:

    < cpumask.h sed -e 's/cpu/node/' -e 's/NR_CPUS/MAX_NUMNODES/' > nodemask.h

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
