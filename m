Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUAJVti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUAJVti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:49:38 -0500
Received: from waste.org ([209.173.204.2]:32659 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265442AbUAJVtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:49:36 -0500
Date: Sat, 10 Jan 2004 15:49:30 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
Message-ID: <20040110214930.GM18208@waste.org>
References: <20040103030814.GG18208@waste.org> <m13cawi2h8.fsf@ebiederm.dsl.xmission.com> <20040104084005.GU18208@waste.org> <m1ekufgt72.fsf@ebiederm.dsl.xmission.com> <20040105170938.GY18208@waste.org> <m1wu82i6tm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wu82i6tm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 12:22:29PM -0700, Eric W. Biederman wrote:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > On Sun, Jan 04, 2004 at 05:00:49PM -0700, Eric W. Biederman wrote:
> > > On the side of useless ugly.  But interesting in what I had to touch
> > > the following patch is a first crude stab at removing block device
> > > support from the kernel.
> > 
> > This looks good. If you can send me a version with
> > /BLOCK_DEVICE/BLOCK/, etc., I'll put it in.
> 
> Ok.  I have just had a chance to clean some things up.  Attached
> is my latest and hopefully clean set up diffs against 2.6.1-rc1-tiny1
> 
> I am bouncing this off of linux-kernel as well since I got such good
> feedback last time.
> 
> - First the compile fixes, so I can compile test this code.

Ok, had this stuff in my last release.

> - Then the CONFIG_BLOCK patch.  

Merged with some minor tweaks in 2.6.1-tiny1.

> - Then a new patch that was sort of in my tree to make BINFMT_SCRIPT
>   configurable.

Merged.

> - And another new patch to use cond_syscall instead of explicit
>   dummies when we don't have the AIO code compiled in.

I went back and cleaned up all my syscall changes to use the
cond_syscall approach, thanks for pointing it out.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
