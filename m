Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVFGNN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVFGNN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVFGNN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:13:29 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:34649 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261853AbVFGNN0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:13:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WHyu3rC+XVWLkeZJwnQIm3PvQzBBzokIyPSZB8Sj7J+DQKZh8+n4o1NDry78tEdBHqLbUj8C87raWicAw0kolmUOG33/dgopgt8grRZgmQGS22TstkFZ6NYKrJrsPXgDeBrsxema/AwIrShkvHgmE0arXM3Y9RnRlc/fQqt7Woc=
Message-ID: <9a87484905060706136a8780b5@mail.gmail.com>
Date: Tue, 7 Jun 2005 15:13:25 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Resend: [PATCH] crypto: don't check for NULL before kfree(), it's redundant.
Cc: jmorris@intercode.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1DfTul-0002H4-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490506061650477c8b7@mail.gmail.com>
	 <E1DfTul-0002H4-00@gondolin.me.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/05, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > Here's a resend of a patch originally for 2.6.12-rc1-mm4. It still
> > applies to 2.6.12-rc6
> >
> > The patch removes redundant checks of NULL before kfree() in crypto/ .
> >
> > Patch attached as well as inline since I don't know how well gmail
> > handles inline patches.
> 
> I've already merged your patch.  It will be pushed upstream after
> 2.6.12 is released.

Ohh, ok. Thanks.  I need to keep better track of what patches people
have already merged.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
