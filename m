Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313720AbSDHSH5>; Mon, 8 Apr 2002 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313721AbSDHSH4>; Mon, 8 Apr 2002 14:07:56 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:28934 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S313720AbSDHSHz>; Mon, 8 Apr 2002 14:07:55 -0400
Date: Mon, 8 Apr 2002 19:07:51 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020408180751.GA49568@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.3.96.1020408104259.21476B-100000@gatekeeper.tmr.com> <00a801c1df17$55295ae0$95dc0e50@machine1> <m1g026m5zx.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 11:53:38AM -0600, Eric W. Biederman wrote:

> If you are going to be doing strange things I don't see why that shouldn't
> still be required.

Practically speaking System.map is often wrongly installed. Additionally
Keith Owens has (sensibly I think) refused to support this sort of
thing.

> Though I am wondering if the sane approach for a profiler might not to be
> have a kernel conditional compilation directive that simply patches
> the syscall path.  The overhead is probably less as well.

This would be OK for us, iff it was on by default. We want to avoid
forcing users to install kernel source and compile up a new kernel,
because it's not just useful for kernel profiling.

Currently it's just a matter of install the module and go, which is
undeniably very useful.

regards
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
