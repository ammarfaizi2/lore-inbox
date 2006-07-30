Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWG3KIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWG3KIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWG3KIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:08:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:43489 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932182AbWG3KIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:08:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ie3qD/VJ1XsE/pJRf5MhuXzSNITZKGZ7C9yQx20mHZB1mE9zSkVQM0yc5RvPp/R4h1ql/xB/B1+5qotskKA+BQ0yVlkJ5x8j08d5YwEScYY+ztk1/h5TZ0Z/wtyG10TXa5ccKovoiWd/W0XkmlfY+R87rQ3fFi15GY+bqrd30Wk=
Message-ID: <9a8748490607300308p7c0eb5afpe9c6305527a608d@mail.gmail.com>
Date: Sun, 30 Jul 2006 12:08:48 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Hans Reiser" <reiser@namesys.com>
Subject: Re: possible recursive locking detected - while running fs operations in loops - 2.6.18-rc2-git5
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       "Al Viro" <viro@ftp.linux.org.uk>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, akpm@osdl.org,
       "Alexander Zarochentcev" <zam@namesys.com>
In-Reply-To: <44CC0161.60806@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
	 <20060725232924.GU6452@schatzie.adilger.int>
	 <9a8748490607291518m59573244wac00486a64f6385b@mail.gmail.com>
	 <44CBEA7A.4010308@namesys.com>
	 <9a8748490607292317t405c906ek8b1577920eeace65@mail.gmail.com>
	 <44CC0161.60806@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Hans Reiser <reiser@namesys.com> wrote:
> Jesper Juhl wrote:
>
> > On 30/07/06, Hans Reiser <reiser@namesys.com> wrote:
> >
> >> Jesper Juhl wrote:
> >>
> >> >
> >> > Thanks. That's a nice little test suite.
> >> >
> >> Yes, it is quite useful, our developers have added it to the regression
> >> suite....
> >>
> > That's nice.
> >
> > Now how about that lock validator message I managed to tease out?
> >
> > Akpm said "... the reiserfs locking appears to be unneeded - this inode
> > is going down and nobody else can look it up, so what is to be locked
> > against?" - can you comment on that?
> >
> >
> Err, how about Zam handles all locking issues and this is Sunday with
> the family?  I know, lame, but he'll answer you on Monday Russian
> time.....;-)
>
:-) Not a problem at all.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
