Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVAMETc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVAMETc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 23:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVAMETc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 23:19:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261481AbVAMET3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 23:19:29 -0500
Date: Wed, 12 Jan 2005 23:18:32 -0500
From: Dave Jones <davej@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@redhat.com
Subject: Re: [PATCH] kill symbol_get & friends
Message-ID: <20050113041831.GB26848@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dwmw2@redhat.com
References: <20050112203136.GA3150@lst.de> <1105575573.12794.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105575573.12794.27.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 11:19:33AM +1100, Rusty Russell wrote:
 
 > The lack of users is because, firstly, dynamic dependencies are less
 > common than static ones, and secondly because the remaining inter-module
 > users (AGP and mtd) have not been converted.  Patches have been sent
 > several times, but maintainers are distracted, it seems.

Patch for AGP is going to go in real soon. I wanted to get the
other agp stuff currently in Andrews tree out of the way first
as its quite large, and I feel Mikes pain in having to rediff
that stuff constantly due to more trivial changes taking place.

 > I *will* run out of patience and push those patches which take away
 > intermodule.c one day (hint, hint!).

I must not respond to Rusty's taunts..

8-)
		Dave

