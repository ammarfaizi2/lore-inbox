Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUDFHDC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbUDFHDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:03:02 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:6228 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263639AbUDFHC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:02:58 -0400
Date: Tue, 6 Apr 2004 00:02:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040406000213.119df23b.pj@sgi.com>
In-Reply-To: <1081233543.15274.190.camel@bach>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
	<20040405230601.62c0b84c.pj@sgi.com>
	<1081233543.15274.190.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Agreed.  That's a big benefit of cutting it out altogether.

And if it wasn't that this would result in requiring every call to
specify the number of bits, resulting in one more chance for a stupid
error, and one less for type checking, I'd vote to remove
cpumask_t/nodemask_t, as I understand you would prefer.

One should resist infrastructure if one can nuke a layer entirely.

But half-baked layers introduce one more form of difficult to
remember inconsistency.

Hmmm ... 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
