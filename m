Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWAFS0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWAFS0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWAFS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:26:47 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:9515 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964813AbWAFS0q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:26:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CrUjOWRq/5tXEdL1UK2xWhXtsW8dgYQP7lSn5RIsKYI39QZkRdqLlXGid/8rs4OVUgBF0M4DdxbxQ1IFCd0845cSKyo55PxpkXws7etCdXqM1NO2WWgv2nbmkWaJekZsT05ZJ2YPWR7gzLbs+PgW8RxSKcwhBfBuZYT5PUfcohE=
Message-ID: <9a8748490601061026t3e467dfdxc90b6403bbd45802@mail.gmail.com>
Date: Fri, 6 Jan 2006 19:26:45 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060106180626.GV12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060106173547.GR12131@stusta.de>
	 <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
	 <20060106180626.GV12131@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Jan 06, 2006 at 06:49:55PM +0100, Jesper Juhl wrote:
> > On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > Do not allow people to create configurations with CONFIG_BROKEN=y.
> > >
> > > The sole reason for CONFIG_BROKEN=y would be if you are working on
> > > fixing a broken driver, but in this case editing the Kconfig file is
> > > trivial.
> > >
> > > Never ever should a user enable CONFIG_BROKEN.
> > >
> > I disagree (slightly) with this patch for a few reasons:
> >
> > - It's very convenient to be able to enable it through menuconfig.
>
> And when do you really need it?
>
Hmm, when I'm looking for broken stuff to fix ;)
I guess you are right, ordinary users don't need it.. Ok, count me in
as supporting this move.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
