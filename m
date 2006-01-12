Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161319AbWALVkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbWALVkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbWALVkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:40:51 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:41302 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161319AbWALVku convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:40:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HwpyhzNeEFfxVfLqtjiZK9V5981clhLPvZHVodd0m87PnM30gg7o4Wess39Tipb8ltnFljPf78AMfyfjBN+xNZwlrGZo3DS6QcNskrKy574oh6bAO/YOGUSmjDlx2WPWkAAOemvEzlbEkgrNqLgkFKolazo64FeJzh4P4MJeD+g=
Message-ID: <21d7e9970601121233t1e6c2d99pf6ca3a4569d5a6d7@mail.gmail.com>
Date: Fri, 13 Jan 2006 07:33:15 +1100
From: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git tree] drm tree for 2.6.16-rc1
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
	 <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Hi Linus,
> >       Can you pull the drm-forlinus branch from
> > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> >
> > This is a pretty major merge over of DRM CVS, and every driver in the DRM
> > is brought up to latest versions....
>
> I'm actually somewhat inclined to not pull any more. We've had lots of
> (hopefully minor) issues for the last few days, and I know that people
> had DRM issues with the -mm tree (which I assume tracked this tree) not
> more than a week or so ago.
>

Actually none of this tree was causing problems in -mm it was the
agpgart tree, this tree is fully tested on all my available hardware,
it is also the first tree that supports multiple cards properly
without oopsing on module remove....

Dave.
