Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTCDAEr>; Mon, 3 Mar 2003 19:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTCDAEq>; Mon, 3 Mar 2003 19:04:46 -0500
Received: from holomorphy.com ([66.224.33.161]:28566 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265791AbTCDAEq>;
	Mon, 3 Mar 2003 19:04:46 -0500
Date: Mon, 3 Mar 2003 16:14:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <20030304001458.GD1399@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030302210606.GS24172@holomorphy.com> <85980000.1046642338@[10.10.2.4]> <20030302221037.GK1195@holomorphy.com> <87420000.1046646801@[10.10.2.4]> <20030302234252.GL1195@holomorphy.com> <88060000.1046650020@[10.10.2.4]> <20030303014320.GM1195@holomorphy.com> <29220000.1046713200@[10.10.2.4]> <20030303225115.GP1195@holomorphy.com> <560080000.1046734218@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560080000.1046734218@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Then there must have been something important in the new per_cpu users.

On Mon, Mar 03, 2003 at 03:30:18PM -0800, Martin J. Bligh wrote:
> -pernode2 had all your changes ... but I still don't see anything like
> the order of magnitude of benefit you were seeing.

Well, something in the mix of new per_cpu and/or per_node users caused
a regression on "that unmentionable benchmark". There's something
different about 2.5.x and 2.4.x kernel compiles that makes the numbers
incomparable. And since the total sum of the benefit of the new
per_cpu/per_node users is negligible along with the total benefit of
the entire thing, there must be something different going on.

Maybe the effect is just tiny, maybe there isn't enough locality of
reference for this to ever do anything, or maybe 2.4.x and 2.5.x
kernel compiles are really that different.

I haven't really got the patience for that kind of an investigation.
It wasn't a slam dunk so I'd rather not bother with it anymore now.


-- wli
