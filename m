Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWG0UOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWG0UOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWG0UOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:14:09 -0400
Received: from alnrmhc13.comcast.net ([204.127.225.93]:2440 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750714AbWG0UOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:14:07 -0400
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
From: Nicholas Miell <nmiell@comcast.net>
To: ricknu-0@student.ltu.se
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <1154030149.44c91a453d6b0@portal.student.luth.se>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <1153945705.44c7d069c5e18@portal.student.luth.se>
	 <200607270448.03257.arnd.bergmann@de.ibm.com>
	 <1153978047.2807.5.camel@entropy>
	 <1154030149.44c91a453d6b0@portal.student.luth.se>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 13:13:59 -0700
Message-Id: <1154031240.2535.1.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 21:55 +0200, ricknu-0@student.ltu.se wrote:
> Citerar Nicholas Miell <nmiell@comcast.net>:
> 
> > If _Bool does end up in the user-kernel ABI, be advised that validating
> > them will be tricky ("b == true || b == false" or "!!b" won't work), and
> 
> Why would !!b not work?
> I don't think it should end up in the ABI (at least, not yet). Just asking
> because I'm curious. :)
> 

The compiler knows that "b = !!b;" is a no-op.

-- 
Nicholas Miell <nmiell@comcast.net>

