Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUDFGfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUDFGfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:35:18 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:18962 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263633AbUDFGfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:35:12 -0400
Date: Mon, 5 Apr 2004 23:34:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040405233415.2c7c3a96.pj@sgi.com>
In-Reply-To: <40724CF4.5090705@yahoo.com.au>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
	<20040405230601.62c0b84c.pj@sgi.com>
	<40724CF4.5090705@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> I like cpumask_t. 

Ok - one vote for cpumask_t.

I could go either way.  I see that 'struct foo' is more common than
'foo_t' in kernel code.

I will not actually propose to change cpumask_t to 'struct cpumask'
unless others want it.  Without a half-way decent reason, it would just
be stupid churning.  But I wouldn't put up much resistance to such a
change.


> And you should not need to look inside it or use it with
> anything other than using the cpumask interface, right?

In my view, right - you (seldom) need to look inside.  From what I can
make of Rusty's statements so far, he apparently has a different view ;).

We'll see.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
