Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUCNWqa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUCNWqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:46:30 -0500
Received: from alt.aurema.com ([203.217.18.57]:9607 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261997AbUCNWq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:46:27 -0500
Date: Mon, 15 Mar 2004 09:46:18 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Trivial Patch] Bad tgid and tid lookup for /proc
Message-ID: <20040315094618.A19791@aurema.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20040209135110.H17768@aurema.com> <20040312005401.DD4032C733@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040312005401.DD4032C733@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Mar 12, 2004 at 09:09:09AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 09:09:09AM +1100, Rusty Russell wrote:
> In message <20040209135110.H17768@aurema.com> you write:
> > All,
> > 
> > On 2.6.2, one can do the following, which is clearly wrong:
> > 
> > gen2 02:49:45 ~: cat /proc/1/task/$$/stat
> > 1669 (bash) S 1668 1669 1669 34816 1730 256 1480 6479 12 4 8 5 5 17 15 0 1 0 
> 8065 3252224 451 4294967295 134512640 134955932 3221225104 3221222840 429496014
> 4 0 65536 3686404 1266761467 3222442959 0 0 17 0 0 0
> > gen2 02:50:44 ~: ls /proc/1/task
> > 1
> 
> Patch was mangled, and IMHO wasn't exactly trivial.  As I understand
> it, you could access any task under /proc/xxx/task.  Your patch seems to
> make it that you can access any task under /proc/xxx/task if xxx is a
> thread group leader.
> 
> A little confused,
> Rusty.

Rusty,

Andrew Morton, Peter Chubb, and a few others actually had a discussion
and resolved some issues around that patch.  So thanks to them I guess
there's no need to be confused ;)

Thanks for looking at it anyway.

-- 
		Kingsley
