Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUJYWOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUJYWOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUJYWOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:14:48 -0400
Received: from holomorphy.com ([207.189.100.168]:8671 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261991AbUJYWNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:13:19 -0400
Date: Mon, 25 Oct 2004 15:08:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Willy Tarreau <willy@w.ods.org>, espenfjo@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041025220808.GA17038@holomorphy.com>
References: <20041023000956.GI17038@holomorphy.com> <417D6CD9.2090702@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417D6CD9.2090702@tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> We aren't just stabilizing 2.6. We're moving it forward. Part of moving
>> forward is preventing backportmania depravity. Backporting is the root
>> of all evil.

On Mon, Oct 25, 2004 at 05:15:05PM -0400, Bill Davidsen wrote:
> Damn! And I thought it was closed source software...
> Let me just put forward my single criterion for stable vs. not, and that 
> is that if I am running a stable kernel and upgrade to a new version to 
> gain a feature or security fix my existing programs don't break. That 
> means to me that if Reiser4 goes in, Reiser3 doesn't exit. If something 
> more please to theoretical cryptographers than cryptoloop comes out, 
> cryptoloop doesn't go away. Etc, these are just examples.

I don't see the kind of thing you're saying should not happen happening.
This does not seem pertinent to -rc vs. other names.


On Mon, Oct 25, 2004 at 05:15:05PM -0400, Bill Davidsen wrote:
> It doesn't bother me (and I believe most users of kernel.org releases) 
> when a new features comes in, until it breaks something even though I 
> don't use the new feature. It's when there is an incompatible change, 
> like the rewrite of modules, that I think a development kernel is needed.

I don't have much of anything to say about modules apart from
"I didn't do it".


On Mon, Oct 25, 2004 at 05:15:05PM -0400, Bill Davidsen wrote:
> I don't see the need for a development kernel, and it is desirable to be 
> able to run kernel.org kernels. I would like to hope that other people 
> agree that stable need not mean static, as long as changes don't 
> deliberately break existing apps.

If we're chucking out crap, there's generally a massive amount of
notice. The only time I've ever been personally burned is kernel rarpd
removal, which did give a major release's worth of notice, but was a
case where I did not find the userspace replacement satisfactory. I'm
still not entirely happy with the userspace rarpd, but get by as it's
been improved since the initial changeover. I suspect there will be
some similar cases coming involving early userspace and so on where
bootloader size limitations vs. new methods burn me regardless of notice.


On Mon, Oct 25, 2004 at 05:15:05PM -0400, Bill Davidsen wrote:
> I note that BSD has another serious fork and that people are actually 
> moving to Linux after installing SP2 and finding it disfunctional with 
> non-MS software. Nice to see people looking at Linux as the stable 
> choice. I would like to hope that continues.

This doesn't really mean much to me. I'm more specifically concerned
with Linux' internals as opposed to e.g. mass-market phenomena or the
various trends going on amongst end users.


-- wli
