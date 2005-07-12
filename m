Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVGLWwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVGLWwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVGLWtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:49:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262321AbVGLWtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:49:36 -0400
Date: Tue, 12 Jul 2005 15:49:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH/URL] reiserfs: reformat code with Lindent
In-Reply-To: <20050712194220.GA28973@locomotive.unixthugs.org>
Message-ID: <Pine.LNX.4.58.0507121546160.17536@g5.osdl.org>
References: <20050712194220.GA28973@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jul 2005, Jeff Mahoney wrote:
> 
>  This patch contains the result of running scripts/Lindent against
>  fs/reiserfs/*.c and include/linux/reiserfs_*.h.

That can't be true. It isn't actually following the Lindent rules. It has 
that braindamaged "put the type on a separate line" thing for function 
declarations, making a "grep" not show the type. That's very much against 
the Linux coding style.

So either your "indent" is broken, or you've used something else than 
Lindent.

Also, if it's a pure indentation change with no other changes, I'd almost 
prefer it as a script, not a patch.  That way it's obvious to everybody 
that it's just doing indentation.

		Linus
