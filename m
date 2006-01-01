Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWAAJv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWAAJv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 04:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWAAJv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 04:51:26 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:59827 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932196AbWAAJvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 04:51:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Phswzf/sPhLS2tkNngZ9e0PnCwoLc25ovcJVItn7Bz+6XK16AT2ySLMGewVWOu0Kt07+FOf/f9drXPsi48A6z8cuB0t4gAFv1YhGVn4b4Zt3lQitF3oNRR3m3SjTffY+0LbpsrE8vM7WlDa/QnBvUkr47HzK01ajxrh+DsbQCeg=
Date: Sun, 1 Jan 2006 11:51:21 +0200
From: Bradley Reed <bradreed1@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Message-ID: <20060101115121.034e6bb7@galactus.example.org>
In-Reply-To: <1136106861.17830.6.camel@laptopd505.fenrus.org>
References: <20051231202933.4f48acab@galactus.example.org>
	<1136106861.17830.6.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs108 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jan 2006 10:14:21 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
> > I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today
> > and they all work fine under 2.6.14 and 2.6.14-rt21/22.
> > 
> > I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault
> > on every video I try and play. Yes, I have nvidia modules loaded,
> > so won't get much help, but thought someone might like to know. 
> 
> 
> you know, you could have done a little bit more effort and reproduced
> this without the binary crud... it's not that hard you know and it
> shows that you actually care about the problem enough that you want
> to make it worthwhile for people to look into it.
> 

And you could have saved the time and effort of replying, as you had
nothing useful to say. Why do you expect kernel users (non-developers) 
to jump through hoops and cripple their systems in order to provide bug
reports? Exactly how could I have tested MPLayer realistically without
Xv support? It isn't that easy to swap video cards in a laptop.

I noticed that after trying a new kernel a user space tool, which
worked fine under earlier kernels, was no longer working. Linus himself
said that this is worth pointing out. I did so. 

Yes, I was very fortunate in that someone else with a non-tainted
kernel noticed a similar bug with /dev/rtc, and even more fortunate
that Steven Rostedt provided a patch that worked for both of us. As I
had said in my original post I was not expecting that, but thought the
bug was worth reporting.

DO YOU REALLY PREFER USERS NOT REPORT BUGS?

Brad


