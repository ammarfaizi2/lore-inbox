Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTLFDII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 22:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTLFDII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 22:08:08 -0500
Received: from holomorphy.com ([199.26.172.102]:47061 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264938AbTLFDIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 22:08:06 -0500
Date: Fri, 5 Dec 2003 19:07:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Colin Coe <colin@coesta.com>, linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206030755.GI8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
	linux-kernel@vger.kernel.org
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD14396.5070205@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 01:48:54PM +1100, Nick Piggin wrote:
> Although in this case Colin has 2 PPro 200s.
> Colin - process load should be evenly distributed between CPUs, and this
> is generally the most important thing. Big networking loads (most commonly)
> can put a lot of time into processing interrupts though.

That is rather busted, then.

Colin, could you try booting with noirqbalance on the kernel command
line?


-- wli
