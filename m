Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbVICGm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbVICGm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbVICGm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:42:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161167AbVICGmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:42:25 -0400
Date: Fri, 2 Sep 2005 23:40:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
       torvalds@osdl.org
Subject: Re: FUSE merging?
Message-Id: <20050902234042.1a7dba6e.akpm@osdl.org>
In-Reply-To: <E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu>
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
	<20050902153440.309d41a5.akpm@osdl.org>
	<E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>  > The main sticking point with FUSE remains the permission tricks around
>  > fuse_allow_task().  AFAIK it remains the case that nobody has come up with
>  > any better idea, so I'm inclined to merge the thing.
> 
>  Do you promise?

I troll.  What others think matters.  But at this stage, objections would
need to be substantial, IMO.  We're rather deadlocked on the permission
thing, but if we can't come up with anything better then I'm inclined to
say what-the-hell.

>   I can do a resplit and submit to Linus, if that takes
>  some load off you.

Nah, then I'd just have to check that everything is the same.
