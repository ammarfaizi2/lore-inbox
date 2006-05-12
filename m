Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWELLLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWELLLF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWELLLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:11:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:26302 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751208AbWELLLE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:11:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HhMautuNPY2gx5ypqRW1zpw2xZ6wK4J3vJAYdwhVyKO2c5Uj7M4v5XD6IrZYdyiZjo4e0Om5uGp0zt91XX5G/H97UjPZagOzrCPKeKD5nYrqW9OuhL+oCke+TugMPFDHqtCQHdlRtTGBWysKbbVbIc6GIuTcCoYGspNFoEKjqTs=
Message-ID: <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com>
Date: Fri, 12 May 2006 13:09:45 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Patrick McHardy" <kaber@trash.net>
Subject: Re: [PATCH] fix mem-leak in netfilter
Cc: "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       sfrost@snowman.net, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
In-Reply-To: <44643BFD.3040708@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060507093640.GF11191@w.ods.org>
	 <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>
	 <20060508050748.GA11495@w.ods.org>
	 <20060507.224339.48487003.davem@davemloft.net>
	 <44643BFD.3040708@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/06, Patrick McHardy <kaber@trash.net> wrote:
> David S. Miller wrote:
> > From: Willy Tarreau <willy@w.ods.org>
> > Date: Mon, 8 May 2006 07:07:48 +0200
> >
> >
> >>I wonder how such unmaintainable code has been merged in the first
> >>place. Obviously, Davem has never seen it !
> >
> >
> > Oh I've seen ipt_recent.c, it's one huge pile of trash
> > that needs to be rewritten.  It has all sorts of problems.
> >
> > This is well understood on the netfilter-devel list and
> > I am to understand that someone has taken up the task to
> > finally rewrite the thing.
>
>
> I haven't seen any cleanup patches so far, so I think I'm
> going to start my nth try at cleaning up this mess.
> Unfortunately its even immune to Lindent ..
>

If you get too fed up with it, let me know, and I'll give it a go as well.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
