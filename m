Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWGZAnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWGZAnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGZAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:43:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3255 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030296AbWGZAnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:43:52 -0400
Date: Tue, 25 Jul 2006 17:42:46 -0700
From: Paul Jackson <pj@sgi.com>
To: ricknu-0@student.ltu.se
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jeff@garzik.org,
       adobriyan@gmail.com, vlobanov@speakeasy.net, jengelh@linux01.gwdg.de,
       getshorty_@hotmail.com, pwil3058@bigpond.net.au, mb@bu3sch.de,
       penberg@cs.helsinki.fi, stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 5)
Message-Id: <20060725174246.6068437c.pj@sgi.com>
In-Reply-To: <1153869727.44c6a79ff1b2b@portal.student.luth.se>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<1153869727.44c6a79ff1b2b@portal.student.luth.se>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard wrote:
> Regarding the #define false/true in include/linux/stddef.h: ... there
> seems to be no use for it (other then userspace programs).

We tend to be biased against doing things in kernel headers just for
userspace programs.  I'd suggest either (1) drop the #define false/true's,
or (2) if a compelling userspace need is presented that wins the day,
at least comment the dang defines.

>From the perspective of what's in the current kernel source, this
pair of defines has lost all sense that I can see.  So they need a
justifying comment if they stay.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
