Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUJ2AHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUJ2AHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbUJ2ABE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:01:04 -0400
Received: from holomorphy.com ([207.189.100.168]:22413 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263160AbUJ1XyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:54:05 -0400
Date: Thu, 28 Oct 2004 16:53:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041028235357.GV12934@holomorphy.com>
References: <200410281937_MC3-1-8D69-AAD0@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410281937_MC3-1-8D69-AAD0@compuserve.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 at 08:03:29 -0700 William Lee Irwin III wrote:
>> 99.99% of users use one arch, i386.

On Thu, Oct 28, 2004 at 07:33:22PM -0400, Chuck Ebbert wrote:
>   You oversimplify.  For example, I have:
[...]

On Thu, 28 Oct 2004 at 08:03:29 -0700 William Lee Irwin III wrote:
>> 99.99% of users use one disk driver, IDE.

On Thu, Oct 28, 2004 at 07:33:22PM -0400, Chuck Ebbert wrote:
>   And again:
[...]
>   So even in my 'simple' i386 environment there is a lot of variety in
> just those two things.

Alan already pointed out the inaccuracies in my statement.

The point is that the distribution is so sharply peaked on such a tiny
subset of the kernel, it's rather predictable what proportion of users
will be affected by a given bug according to what it's in. So, you can
in principle rank the areas of the kernel in need of verification by
this probability distribution, and carry out audits etc. that way. Even
your "variety" of drivers and architectures adds up to a truly tiny
fraction of the kernel. Worse yet, I was already counting the whole of
drivers/ide/, arch/i386/, and include/asm-i386/ in my accounting, so
you're actually describing a narrower subset of the kernel than I was.


On Thu, 28 Oct 2004 at 08:03:29 -0700 William Lee Irwin III wrote:
>> The intersection of these users is probably well over 99.999% of all
>> users.

Union...

On Thu, Oct 28, 2004 at 07:33:22PM -0400, Chuck Ebbert wrote:
>   If Linux had a billion users, how many would have something different?

These arguments are all proportions, but there's actually a rather large
chance that increasing the number of users would all happen by means of
more widely distributing some already-extremely-common hardware. That is,
there would be almost no additional users of the marginalized systems
(even in absolute terms), and the distribution across drivers etc.
would become even more sharply peaked on the same code than it is now.


-- wli
