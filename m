Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVJUNKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVJUNKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVJUNKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:10:14 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:64112 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964941AbVJUNKM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:10:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YWVfgmH6+2WGcUBudbWXR2//qRANcbKZq94LAaCIgThouTBZv4xNxlCEebNMRS6pof2XXolGF3iVxrdkvkT+Ma2kj3xwkArHct7S3E6AxEpVpuAt/ooux9ba2387Q9BVjaKZILqS78X90tCwm1eZOxwoD4K0HDsYbcMPKrr9LT4=
Message-ID: <9a8748490510210610t59e25750u67bf88e3923c4b0b@mail.gmail.com>
Date: Fri, 21 Oct 2005 15:10:11 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: question about code from the linux kernel development ( se ) book
Cc: Yitzchak Eidus <ieidus@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510210848030.3903@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e7aeb7c60510210422s33c0240ex4eab1d90d94111fe@mail.gmail.com>
	 <Pine.LNX.4.58.0510210848030.3903@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Oh God, please indent code examples, and if your email client strips white
> space, change your email client.
>
> On Fri, 21 Oct 2005, Yitzchak Eidus wrote:
>
> > first i am very sorry if it isnt the place to ask questions like this
> > but i didnt know where else to ask ( i tryed irc channels and i was
> > send from there to this list )
> > anyway:
> > does this following code look buggy? :
>
> [ Indention added ]
>
Thanks.

> > DECLARE_WAITQUEUE ( wait , current );
> > add_wait_queue ( q , &wait );
> > while ( !condition ) {
> >         set_current_stat ( TASK_INTERRUPTABLE ); i

It is probably just a typo, but that "i" at the end of the line would be a bug.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
