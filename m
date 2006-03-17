Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWCQN24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWCQN24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWCQN24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:28:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:43217 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750732AbWCQN2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:28:55 -0500
Message-ID: <441AB9A9.2000704@de.ibm.com>
Date: Fri, 17 Mar 2006 14:29:13 +0100
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>	 <20060316163728.06f49c00.akpm@osdl.org>	 <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org> <1142571490.9022.37.camel@localhost.localdomain> <441A7E34.90508@sgi.com>
In-Reply-To: <441A7E34.90508@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Well then the question is, would it simplify the code using no_pfn in
> this case? Hacking up fake struct page entries seems even more of a
> hack to me.
I second that. That's were we are with our dcss xip thing today.
It _is_ a hack to have a struct page that you don't need.

Carsten
