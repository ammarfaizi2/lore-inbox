Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUH0Qlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUH0Qlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUH0Qlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:41:55 -0400
Received: from holomorphy.com ([207.189.100.168]:46495 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266585AbUH0QlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:41:22 -0400
Date: Fri, 27 Aug 2004 09:41:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [0/2][ANNOUNCE] nproc: netlink access to /proc information
Message-ID: <20040827164111.GQ2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <1093624660.431.6128.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093624660.431.6128.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 12:23, William Lee Irwin III wrote:
>> I see no evidence that this will be a speedup with large numbers of
>> processes, as the problematic algorithms are preserved wholesale.

On Fri, Aug 27, 2004 at 12:37:40PM -0400, Albert Cahalan wrote:
> Well, as far as THAT goes, I thought your tree-based
> lookup was nice. I assume you still have the code.
> What we got instead was a sort of cached directory
> offset computation, which looks great... until you
> hit the bad case. I suggest that the people trying to
> reduce latency should try "top -d 0 -b >> /dev/null"
> while running something like the SDET benchmark.

I can resurrect that easily enough.


-- wli
