Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVI1SFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVI1SFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVI1SFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:05:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750707AbVI1SFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:05:47 -0400
Date: Wed, 28 Sep 2005 11:03:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, akpm@osdl.org
Subject: Re: [PATCH] cpuset read past eof memory leak fix
In-Reply-To: <20050928105316.0684c7cf.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0509281100580.3308@g5.osdl.org>
References: <20050908225539.0bc1acf6.pj@sgi.com> <20050909.203849.33293224.taka@valinux.co.jp>
 <20050909063131.64dc8155.pj@sgi.com> <20050910.161145.74742186.taka@valinux.co.jp>
 <20050910015209.4f581b8a.pj@sgi.com> <20050926093432.9975870043@sv1.valinux.co.jp>
 <20050927013751.47cbac8b.pj@sgi.com> <20050927113902.C78A570046@sv1.valinux.co.jp>
 <20050928092558.61F6170041@sv1.valinux.co.jp> <20050928064224.49170ca7.pj@sgi.com>
 <Pine.LNX.4.58.0509280758560.3308@g5.osdl.org> <20050928105316.0684c7cf.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Sep 2005, Paul Jackson wrote:
> 
> Too bad that first line doesn't start "Author:" instead of "From:".
> Oh well - I see Andrew already suggested that, and you declined.
> (You should'a listened to him ;).

The "From:" rule has been implicit in my tools for a _loong_ time, and
switching to "Author:" would just break the tools for no actual technical
gain. Not just the tools, either, since Andrew isn't the only one who
follows that From: rule - it would break "people".

So you'd have to make the tools accept _both_ "From:" and "Author:", and I 
personally prefer an _unambiguously_ slightly misnamed thing over some 
"either X or Y" where X is slightly misnamed but accepted because it's the 
one more commonly used.

It's like the unix "creat()" system call. Sure, it would make more sense 
to add the "e", but it wouldn't actually really _help_ anybody.

As to documenting the "From:" thing - yes, we probably should. It's quite 
commonly used.

		Linus
