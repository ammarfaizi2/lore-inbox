Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVBXCI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVBXCI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVBXCI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:08:58 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:49610 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261694AbVBXCHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:07:54 -0500
Date: Wed, 23 Feb 2005 18:07:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Jay Lan <jlan@sgi.com>
Cc: kaigai@ak.jp.nec.com, akpm@osdl.org, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050223180732.3ecd3894.pj@sgi.com>
In-Reply-To: <421D3448.7050209@sgi.com>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
	<20050223172551.6771ce7a.pj@sgi.com>
	<421D3448.7050209@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay wrote:
> I think the microbenchmarking your link provides is irrelevant.

In the cases such as you describe where it's just some sort of empty
function call, then yes, I am willing to accept a wave of the hands and
a simple explanation of how it's not significant.  I've done the same
myself ;).

What about the case where accounting is enabled, and thus actually has
to do work?

How does that compare with just doing the traditional BSD accounting?

I presume in that case that the benchmarking is no longer irrelevant.
Though if you can make a decent case that it is, I'm willing to listen.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
