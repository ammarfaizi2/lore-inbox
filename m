Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVHRVOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVHRVOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVHRVOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:14:39 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:52625 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932449AbVHRVOi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:14:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MtmRyKiE23nkSM7pWfY2wlKgSNBf63CGq+QFklLhhz0LdBQv3omCd1xsRhiaDswCVp63NI9Odzm0ruQrDRoC3JqnrcoUkOE61uXkvbT8RP+CGF2w09a9/bdDpXg1SAYRepKG2tmNNhSpCJUJIAcWqa5JWDbwwBg/QBSVa7xvY1M=
Message-ID: <9a87484905081814145a58d160@mail.gmail.com>
Date: Thu, 18 Aug 2005 23:14:38 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/7] rename locking functions - do the rename
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050818110051.GA6606@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508180207.14574.jesper.juhl@gmail.com>
	 <20050818110051.GA6606@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Aug 18, 2005 at 02:07:14AM +0200, Jesper Juhl wrote:
> > This patch renames sema_init to init_sema, init_MUTEX to init_mutex and
> > init_MUTEX_LOCKED to init_mutex_locked  and at the same time creates 3
> > (deprecated) wrapper functions with the old names.
> 
> What's the point?  There's not need for totally gratious renaming.
> 
I don't consider this "gratious renaming". I didn't do this just
because I could. I did it because the names used in the locking API
are quite inconsistent and not exactely pretty. I did it to make
things cleaner, neater, more consistent - to do everyone a favour.

Yes, it's just renaming of functions, it doesn't actually change any
behaviour, but why should we have to live with less-than-perfect
naming when we can clean it up?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
