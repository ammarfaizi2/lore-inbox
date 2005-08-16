Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVHPBRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVHPBRB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVHPBRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:17:00 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29688 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965062AbVHPBQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:16:58 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
	between /dev/kmem and /dev/mem)
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org>
	 <1123953924.3187.22.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 15 Aug 2005 21:16:40 -0400
Message-Id: <1124155000.5764.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 10:37 -0700, Linus Torvalds wrote:
> 
> On Sat, 13 Aug 2005, Arjan van de Ven wrote:
> > 
> > attached is the same patch but now with Steven's change made as well
> 
> Actually, the more I looked at that mmap_kmem() function, the less I liked 
> it.  Let's get that sucker fixed better first. It's still not wonderful, 
> but at least now it tries to verify the whole _range_ of the mapping.
> 
> Steven, does this "alternate mmap_kmem fix" patch work for you?
> 

Sorry for the late reply, my wife's Grandmother just passed away a few
days ago (at 98 years old) and if I went within 6 feet of the computer
she would have killed me!

I just tried out the patch, and it worked fine for me.

Thanks,

-- Steve


