Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUH0RIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUH0RIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUH0RIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:08:42 -0400
Received: from holomorphy.com ([207.189.100.168]:56223 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266657AbUH0RIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:08:40 -0400
Date: Fri, 27 Aug 2004 10:08:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [0/2][ANNOUNCE] nproc: netlink access to /proc information
Message-ID: <20040827170839.GS2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040827170143.GA31918@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827170143.GA31918@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 09:23:08 -0700, William Lee Irwin III wrote:
>> I see no evidence that this will be a speedup with large numbers of
>> processes, as the problematic algorithms are preserved wholesale.

On Fri, Aug 27, 2004 at 07:01:43PM +0200, Roger Luethi wrote:
> It doesn't fundamentally change the complexity, but I expect the
> reduction in overhead to be noticeable, mostly due to:
> - no more string parsing.
> - fewer system calls.
> - fewer cycles wasted on calculating unnecessary data fields.

After some closer review it appears recent algorithmic improvements
are largely orthogonal to your interface change; the new interface
may just call the improved algorithms.


-- wli
