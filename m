Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUFRAhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUFRAhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUFRAhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:37:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:39888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264890AbUFRAhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:37:06 -0400
Date: Thu, 17 Jun 2004 17:39:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-Id: <20040617173953.39eae56c.akpm@osdl.org>
In-Reply-To: <40D232AD.4020708@opensound.com>
References: <40D232AD.4020708@opensound.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4Front Technologies <dev@opensound.com> wrote:
>
> This is absolutely not our problem and we don't know who to contact at SuSE to fix
> this problem. Our software works perfectly with Fedora/Debian/Gentoo/Mandrake/Redhat/etc.

Are you referring to userspace applications which fail under Suse's kernel,
or are you referring to kernel code?

If the former then yes, this may well be a bug in the Suse kernel - please
provide the means to reproduce it.

If the latter (your drivers don't work in Suse's kernel) then this too
could be a bug in the Suse changes, or in your driver.  Again, more details
would be needed to diagnose it.


I expect your distress is a little misplaced - someone somewhere has a
silly little bug and once that's found and fixed, things will be OK.


As to your broader point - yes, I too am disturbed by *any* divergence from
a kernel.org kernel.  Because it means that there is some feature which the
mainstream kernel is missing, or some problem which remains unresolved. 
Especially if there are variations in user-visible features - that would be
very bad for everyone.

Either way, each unmerged patch is a little failing which costs the users
of the patched kernel as well as the users of the unpatched kernels.

I don't have a lot of substantiation for this, but I think the reason why
suse are sitting on 1500 patches is a combination of:

a) They're on 2.6.5 and have included a lot of patches which are already in
   2.6.6 and 2.6.7

b) They shipped the kitchen sink with 2.4 and their customers still want
   to wash the dishes in 2.6.

c) Maybe they haven't been terribly stern about throwing things away.


I would like to see a little more all-round effort to reduce the variation
between kernels, and perhaps Suse moved onto 2.6 a little later than they
should and have a resourcing problem.  Hopefully we'll be seeing more
patches from them soon.
