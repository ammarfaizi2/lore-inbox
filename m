Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267781AbTBVT4U>; Sat, 22 Feb 2003 14:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbTBVT4U>; Sat, 22 Feb 2003 14:56:20 -0500
Received: from holomorphy.com ([66.224.33.161]:32425 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267781AbTBVT4T>;
	Sat, 22 Feb 2003 14:56:19 -0500
Date: Sat, 22 Feb 2003 12:05:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222200521.GD10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com> <1045938019.5034.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045938019.5034.9.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 00:16, Larry McVoy wrote:
>> And with the embedded market being one of the few real money makers
>> for Linux, there will be huge pushback from those companies against
>> changes which increase memory footprint.

On Sat, Feb 22, 2003 at 06:20:19PM +0000, Alan Cox wrote:
> I think people overestimate the numbner of large boxes badly. Several IDE
> pre-patches didn't work on highmem boxes. It took *ages* for people to
> actually notice there was a problem. The desktop world is still 128-256Mb
> and some of the crap people push is problematic even there. In the embedded
> space where there is a *ton* of money to be made by smart people a lot
> of the 2.5 choices look very questionable indeed - but not all by any
> means, we are for example close to being able to dump the block layer,
> shrink stacks down by using IRQ stacks and other good stuff.

Well, I've never seen IDE in a highmem box, and there's probably a good
reason for it. The space trimmings sound pretty interesting. IRQ stacks
in general sound good just to mitigate stackblowings due to IRQ pounding.


On Sat, Feb 22, 2003 at 06:20:19PM +0000, Alan Cox wrote:
> I'm hoping the Montavista and IBM people will swat each others bogons 8)

Sounds like a bigger win for the bigboxen, since space matters there,
but large-scale SMP efficiency probably doesn't make a difference to
embedded (though I think some 2x embedded systems are floating around).


-- wli
