Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752365AbWKCI6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbWKCI6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbWKCI6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:58:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63973 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752365AbWKCI6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:58:40 -0500
Date: Fri, 3 Nov 2006 00:57:47 -0800
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jes@sgi.com, lse-tech@lists.sourceforge.net,
       sekharan@us.ibm.com, hch@lst.de, viro@zeniv.linux.org.uk,
       sgrubb@redhat.com, linux-audit@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 0/9] Task Watchers v2: Introduction
Message-Id: <20061103005747.60bfbd87.pj@sgi.com>
In-Reply-To: <20061103042257.274316000@us.ibm.com>
References: <20061103042257.274316000@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> Task watchers is primarily useful to existing kernel code as a means of making
> the code in fork and exit more readable.

I don't get it.  The benchmark data isn't explained in plain English
what it means, that I could find, so I am just guessing.  But looking
at the last (17500) column of the fork results, after applying patch
1/9, I see a number of 18565, and looking at that same column in patch
9/9, I see a number of 18142.

I guess that means a drop of (18565 - 18142 / 18565) == 2% in the fork
rate, to make the code "more readable".

And I'm not even sure it makes it more readable.  Looks to me like another
layer of apparatus, which is one more thing to figure out before a reader
understands what is going on.

I'd gladly put in a few long days to improve the fork rate 2%, and I am
grateful to those who have already done so - whoever they are.

Somewhere I must have missed the memo explaining why this patch is a
good idea - sorry.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
