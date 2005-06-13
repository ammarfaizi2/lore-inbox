Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVFMV3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVFMV3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVFMV0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:26:31 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:43855 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261392AbVFMVWE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:22:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BvUTUV7NhpRiiDhpr35zAHYtu2+tohAV9qE0Mr1ogGQuITr83Qka50bOFHjZmFfitEm+FU0en+pqAFo9cY2iSw2mX5gA8vkVlW8AeW+J1bXSh6dUotsQRNeuEP0WD0vRfDu8Dv+q1FkgFAvZzeLQ4vT5y4nLZU/AbLKJyRKjAlg=
Message-ID: <9a8748490506131421707008ed@mail.gmail.com>
Date: Mon, 13 Jun 2005 23:21:56 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: fix sparse warning (plain int as NULL)
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org, ross.biro@gmail.com,
       netdev@oss.sgi.com
In-Reply-To: <20050613.135950.48528369.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506122358570.16521@dragon.hyggekrogen.localhost>
	 <20050613.135950.48528369.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/05, David S. Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <juhl-lkml@dif.dk>
> Date: Mon, 13 Jun 2005 00:05:33 +0200 (CEST)
> 
> > Here's a patch to fix a small sparse warning in net/ipv4/tcp_input.c :
> > net/ipv4/tcp_input.c:4179:29: warning: Using plain integer as NULL pointer
> >
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> Please patch against Linus's tree, -mm has a ton of TCP changes
> in it so this patch wouldn't apply to the current GIT tree
> without rejects.
> 
Since tcp_ack_saw_tstamp() in 2.6.12-rc6-git6 only takes two arguments
this patch is only relevant for -mm.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
