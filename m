Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbTIQByU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 21:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTIQByU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 21:54:20 -0400
Received: from holomorphy.com ([66.224.33.161]:32721 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262588AbTIQByT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 21:54:19 -0400
Date: Tue, 16 Sep 2003 18:55:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ben Johnson <ben@blarg.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030917015527.GX4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ben Johnson <ben@blarg.net>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030916154747.A22526@blarg.net> <1562370000.1063759683@[10.10.2.4]> <20030917005446.GW4306@holomorphy.com> <1563260000.1063760286@[10.10.2.4]> <20030916184421.A25733@blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916184421.A25733@blarg.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 06:44:21PM -0700, Ben Johnson wrote:
> Thank you.  I've been reading the first addition.  is there a second?
> the second chapter has a very good explanation of paging and how linear
> addresses are used.  logical addresses on the other hand are barely
> mentioned.  Segmentation is described well, but the translation of
> logical into linear addresses is not described.
> I've read elsewhere that logical addresses are comprised of a 16-bit
> segment selector and a 32-bit offset.  I thought pointers were always
> exactly 32-bits (on 32-bit intel).  where is the 16-bit selector?

You might want to look at intel's volume 3. They're kept in dedicated
registers separate from the pointers and used implicitly.


-- wli
