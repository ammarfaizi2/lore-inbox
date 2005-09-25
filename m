Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVIYIai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVIYIai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVIYIai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:30:38 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:32642 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751244AbVIYIai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:30:38 -0400
Date: Sun, 25 Sep 2005 09:30:24 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Michael Veeck <michael.veeck@gmx.net>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove DRM_ARRAY_SIZE
In-Reply-To: <1127636422.16288.1.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0509250923020.30376@skynet>
References: <20050924211139.GA18795@mipter.zuzino.mipt.ru> 
 <Pine.LNX.4.58.0509250054190.24532@skynet> <1127636422.16288.1.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> ok so this brings the question: how does naming it DRM_ARRAY_SIZE make
> it more portable than naming it ARRAY_SIZE?
> If *BSD doesn't have ARRAY_SIZE, then surely naming it ARRAY_SIZE is
> easy for them to provide (after all they need to provide it already just
> called DRM_ARRAY_SIZE); if they have ARRAY_SIZE... then I assume it has
> the exact same semantics....
>

Yes I've heard this argument before, and it works for ARRAY_SIZE, but I'm
not sure it'll be okay for all macros we use, the other thing is I've no
idea what BSD or Solaris have or don't have, so if we just DRM_ most
things it makes it less likely we'll have a namespace clash later on ...

I'm not really caring either way though, I prefer to leave it as is unless
someone comes up with a really good reason as I'm lazy by nature, and I
don't think it really affects anyone either way... there are a lot worse
things in the drm that need looking at on my list before I start worrying
about naming macros...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

