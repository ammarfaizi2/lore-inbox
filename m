Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVAJRRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVAJRRC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAJRRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:17:01 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:34183 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262335AbVAJRQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:16:58 -0500
Date: Mon, 10 Jan 2005 09:16:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       linux-ia64@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V3 [1/4]: Allow request for zeroed memory
In-Reply-To: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005, Hugh Dickins wrote:

> Christoph, a late comment: doesn't this effectively replace
> do_anonymous_page's clear_user_highpage by clear_highpage, which would
> be a bad idea (inefficient? or corrupting?) on those few architectures
> which actually do something with that user addr?

Yes. Right my ia64 centric vision got me again. Thanks for all the other
patches that were posted. I hope this is now all cleared up?

