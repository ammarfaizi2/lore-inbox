Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318812AbSHES0l>; Mon, 5 Aug 2002 14:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318815AbSHES0l>; Mon, 5 Aug 2002 14:26:41 -0400
Received: from angband.namesys.com ([212.16.7.85]:27356 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318812AbSHES0k>; Mon, 5 Aug 2002 14:26:40 -0400
Date: Mon, 5 Aug 2002 22:30:16 +0400
From: Oleg Drokin <green@namesys.com>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
Message-ID: <20020805223016.A14603@namesys.com>
References: <20020805150436.A1176@namesys.com> <Pine.LNX.4.44.0208052014220.31879-100000@pc40.e18.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208052014220.31879-100000@pc40.e18.physik.tu-muenchen.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 05, 2002 at 08:19:05PM +0200, Roland Kuhn wrote:
> > > > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 
> >From there I get 'permission denied', but I got it somewhere else (google 
> is great).
> However, it does not apply cleanly to 2.4.19. It is already partly in, as 
> it seems, but there are some rejects that are not obvious to fix for me. 
> If this patch still makes sense, it would be great if someone with more 
> knowledge/experience than me could have a look...

In the same dir there is 
03-data-logging-24.diff.gz
It contains this patch and more stuff, you can try it.

> > No, it is not possible to begin "new journal" in reiser3.
> Is this going to change in reiser4?

Sort of, there would be no static journal.

Bye,
    Oleg
