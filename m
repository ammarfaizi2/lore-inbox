Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVIWXCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVIWXCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVIWXCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:02:07 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:25010 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932094AbVIWXCF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:02:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KXi2yxmUcx+W+IXGsmuVWyFGerk7Okv4Fhw4SW1HB7/IoENhEl0tjM2DcIcLnlKRV5Ci6wbAqUf2bEfcyl7xeOe/85169DWCj1kSCB91/bKnUMhNaGzYxWMFMelQoUUoyjxKKXeK0AHbeDaXccFOnUxA0SN5cDUXwuit146ELYc=
Message-ID: <9a874849050923160258168853@mail.gmail.com>
Date: Sat, 24 Sep 2005 01:02:04 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/3] lib/string.c cleanup : whitespace and CodingStyle cleanups
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Ingo Oeser <ioe@informatik.tu-chemnitz.de>,
       Jason Thomas <jason@topic.com.au>,
       Matthew Hawkins <matt@mh.dropbear.id.au>
In-Reply-To: <20050923230521.GA6915@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509232344.26044.jesper.juhl@gmail.com>
	 <200509232348.45030.jesper.juhl@gmail.com>
	 <20050923230521.GA6915@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Fri, Sep 23, 2005 at 11:48:44PM +0200, Jesper Juhl wrote:
> > Whitespace and CodingStyle cleanups for lib/string.c
> >
> > Removes some blank lines, removes some trailing whitespace, adds spaces
> > after commas and a few similar changes.
>
> > -char * strcpy(char * dest,const char *src)
> > +char *strcpy(char *dest, const char *src)
>         ^^^
>
> Why? Seriously.
>

Two reasons

1) it matches the style most commonly used in the kernel

2) when I (and i suspect others) see
   <foo> * <bar>   my first thought is "multiplication"
   but when I see
   <foo> *<bar>   my first thought is "ptr variable" or "function returning ptr"


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
