Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWEONEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWEONEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWEONEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:04:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:60523 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932409AbWEONEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:04:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lDKDESjYDqJCZwcypwqEevSmUtpYbgbiwwWJFoG0z4Q6iaTwpMum6NHR3vRtkehHOJouDpLwKbbW0gm91XzdYfNvrjViUx9KfQXNyDCCdVCBmxkxZdU3UvxYNaoB//UdecvVV4a/pPKZgjkdET7LREvO1bzvri6b9XcBE9XlJSs=
Message-ID: <9a8748490605150604x508861b5o211fe751aba7d608@mail.gmail.com>
Date: Mon, 15 May 2006 15:04:41 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] fix dangerous pointer derefs and remove pointless casts in MOXA driver
Cc: "Alexey Dobriyan" <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       "Moxa Technologies" <support@moxa.com.tw>, "Alan Cox" <alan@redhat.com>,
       "Martin Mares" <mj@ucw.cz>
In-Reply-To: <20060515123545.GB26656@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200605140349.36122.jesper.juhl@gmail.com>
	 <20060514141845.GB23387@mipter.zuzino.mipt.ru>
	 <9a8748490605150253u3c69f030wd59f0619550d2060@mail.gmail.com>
	 <20060515123545.GB26656@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> On Mon, 15 May 2006 11:53:07 +0200, Jesper Juhl wrote:
> > On 14/05/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > >Please, don't make unrelated changes, ever.
> > >
> > Sorry about that.
> > I know that's the general rule, but I guess I've been spoiled by
> > having some of my recent patches merged that did a few trivial things
> > all in one patch and people didn't seem to mind. I'll try to get out
> > of that habbit again.
>
> I _did_ mind.  Just not enough to complain. :)
>
Heh, fair enough. I know I'm the one who's in the wrong and I'll get
back in the "one change per patch file only" habbit - promise :)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
