Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVLKBrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVLKBrw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 20:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVLKBrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 20:47:52 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:1124 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964809AbVLKBrw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 20:47:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJ50+9YIw+ZAdRV8jJgU6H+no96MAQ8ekU1LQz9j6OWivHiK/cH+DixSQLHytsZHhRM/8PW5d1wfLpANOyZJpfdS9ad0t11vvhym7bmPCYLyIVe3jnsrDXU4V7ROlBLWdhJ8+cVkQYNOCHH0zSoMdBvDfMUKS0cJ13Tc9NrF2U4=
Message-ID: <9a8748490512101747p1cdcdf7cs1b8b4b0e67908b94@mail.gmail.com>
Date: Sun, 11 Dec 2005 02:47:51 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Decrease number of pointer derefs in nf_conntrack_core.c
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Core Team <coreteam@netfilter.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051209114935.GA26127@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512082336.19695.jesper.juhl@gmail.com>
	 <20051209110441.GC20314@elte.hu>
	 <9a8748490512090218q72998aebq8c09247921bd167e@mail.gmail.com>
	 <Pine.LNX.4.63.0512091134100.31859@gockel.physik3.uni-rostock.de>
	 <20051209114935.GA26127@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>
> > I get
> > orig:
> >    text    data     bss     dec     hex filename
> >   11745      67     728   12540    30fc net/netfilter/nf_conntrack_core.o
> >
> > patched:
> >    text    data     bss     dec     hex filename
> >   11681      67     728   12476    30bc net/netfilter/nf_conntrack_core.o
>
> yeah, that's OK and in the expected range.
>
Ingo, Tim, you are correct. I did screw up the size measurements for
that one patch. Sorry about that.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
