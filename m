Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbTIQBoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 21:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbTIQBoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 21:44:23 -0400
Received: from blarg.net ([206.124.128.1]:718 "EHLO animal.blarg.net")
	by vger.kernel.org with ESMTP id S262585AbTIQBoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 21:44:22 -0400
Date: Tue, 16 Sep 2003 18:44:21 -0700
From: Ben Johnson <ben@blarg.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030916184421.A25733@blarg.net>
References: <20030916154747.A22526@blarg.net> <1562370000.1063759683@[10.10.2.4]> <20030917005446.GW4306@holomorphy.com> <1563260000.1063760286@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1563260000.1063760286@[10.10.2.4]>; from mbligh@aracnet.com on Tue, Sep 16, 2003 at 05:58:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 05:58:08PM -0700, Martin J. Bligh wrote:
> 
> BTW, to the original question ... chapter 2 of "Understanding the Linux Kernel"
> had a good explanation of all this.

Thank you.  I've been reading the first addition.  is there a second?
the second chapter has a very good explanation of paging and how linear
addresses are used.  logical addresses on the other hand are barely
mentioned.  Segmentation is described well, but the translation of
logical into linear addresses is not described.

I've read elsewhere that logical addresses are comprised of a 16-bit
segment selector and a 32-bit offset.  I thought pointers were always
exactly 32-bits (on 32-bit intel).  where is the 16-bit selector?

Thanks again.

- Ben
