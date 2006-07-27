Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWG0Gw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWG0Gw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 02:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWG0Gw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 02:52:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10374 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751856AbWG0Gw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 02:52:27 -0400
Date: Wed, 26 Jul 2006 23:51:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Nicholas Miell <nmiell@comcast.net>
Cc: arnd.bergmann@de.ibm.com, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, akpm@osdl.org, jeff@garzik.org,
       adobriyan@gmail.com, vlobanov@speakeasy.net, jengelh@linux01.gwdg.de,
       getshorty_@hotmail.com, pwil3058@bigpond.net.au, mb@bu3sch.de,
       penberg@cs.helsinki.fi, stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
Message-Id: <20060726235115.3772ec1e.pj@sgi.com>
In-Reply-To: <1153978047.2807.5.camel@entropy>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<1153945705.44c7d069c5e18@portal.student.luth.se>
	<200607270448.03257.arnd.bergmann@de.ibm.com>
	<1153978047.2807.5.camel@entropy>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas wrote:
> If _Bool does end up in the user-kernel ABI

I'd be inclined to not put a _Bool in that ABI.
I'd stick with the scalar ints and such we have now.

The benefits of compile type checking are weaker
across that ABI, and the demands of compatibility
much higher than they are for kernel internals.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
