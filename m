Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWDYVux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWDYVux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWDYVux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:50:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751327AbWDYVux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:50:53 -0400
Date: Tue, 25 Apr 2006 14:50:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] Revert "[fuse] fix deadlock between fuse_put_super()
 and request_end()"
In-Reply-To: <E1FYJ3b-0006UZ-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.64.0604251447200.3701@g5.osdl.org>
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
 <E1FYJ3b-0006UZ-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Apr 2006, Miklos Szeredi wrote:
>
> This reverts 73ce8355c243a434524a34c05cc417dd0467996e commit.

Btw, I _really_ hate commit messages that just say "this reverts that".

Please please _please_ say why it gets reverted, even if it's just a short 
explanation of what was wrong, and what the right thing is.

And if you have an old version of git that doesn't even start up an editor 
to allow you to talk about why the revert happens (yeah, that was a 
mistake), please do upgrade.

Trust me, you'll find a lot of the other improvements to your liking too.

		Linus
