Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVFXNx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVFXNx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVFXNx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:53:28 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:62275 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261975AbVFXNqY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:46:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pU9SmJEse27AHlo1TpuHvTeyY9UQFjRHEnLXrjg4s4czdM5WIBW+mb8WxfLwctdIJMAMf/tiAbMp0FKBg3kD309pzyJFkrcy7Ye53ijsYwuez7V0bppUY/GD6wIen6aMskFvoeOfCR3C525uB4qCTmU0O8C+ODCfUMVnA+GJUVA=
Message-ID: <4d8e3fd3050624064620a4945e@mail.gmail.com>
Date: Fri, 24 Jun 2005 15:46:21 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Andrea Arcangeli <andrea@suse.de>,
       Petr Baudis <pasky@ucw.cz>, mercurial@selenic.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
In-Reply-To: <20050624133952.GB7445@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	 <20050624064101.GB14292@pasky.ji.cz>
	 <20050624130604.GK17715@g5.random> <20050624133952.GB7445@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/6/24, Theodore Ts'o <tytso@mit.edu>:
> On Fri, Jun 24, 2005 at 03:06:04PM +0200, Andrea Arcangeli wrote:
> > On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> > > Cool. Except where the concepts are just different, Cogito mostly
> > > appears at least equally simple to use as Mercurial. Yes, some features
> > > are missing yet. I hope to fix that soon. :-)
> >
> > The user interface and network protocol isn't the big deal, the big deal
> > is the more efficient on-disk storage format IMHO.
> 
> E2fsprogs with the full revision history imported into git is 100
> megs, and that's with deltas.  E2fsprogs imported into Mercurial is 17
> megs (and actually, the imported repository was just a tad bit smaller
> than e2fsprogs' BK repository).
> 
> Which do you think is going to be faster to operate from a cold start
> using 4200 rpm laptop drives?  :-)
> 
>                                                - Ted

That's quite intersting, what the rational behind such a difference in
terms of disk occupation ?

-- 
Paolo
