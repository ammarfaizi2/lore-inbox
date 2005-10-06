Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVJFO26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVJFO26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbVJFO26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:28:58 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:56361 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750877AbVJFO25 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:28:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y6nc88D/w/mquuCRNVl34Eg1XK7Nvj4v7XrJFxZdN7n8eKiboiolIBXKJUbZF1iHVorUAoPZZQJtx7ScfLpVrbsiE2d7vjroXPXlO4Wuib78dSu4Yvi8h1aFoTu4c9YX79P9RK1Pag1rxx5bfCuYMzq4hAgjpqGl+yi8DYSHuVM=
Message-ID: <9a8748490510060728i30e0ab5do2e6765b952ac343c@mail.gmail.com>
Date: Thu, 6 Oct 2005 16:28:56 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: madhu.subbaiah@wipro.com
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490510060725x34426df0se719458caf9364fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1128606546.14385.26.camel@penguin.madhu>
	 <9a8748490510060725x34426df0se719458caf9364fe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 10/6/05, Madhu K.S. <madhu.subbaiah@wipro.com> wrote:
[snip]
> > +                                usec *= (1000000/HZ);
> Small style thing:   usec *= (1000000 / HZ);
>
Ohh and the parenthesis are not needed.
                                 usec *= 1000000 / HZ;

[snip]
--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
