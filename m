Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbTGHTPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbTGHTNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:13:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39336 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S267537AbTGHTMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:12:49 -0400
Date: Tue, 8 Jul 2003 16:24:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: trond.myklebust@fys.uio.no, hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] Fastwalk: reduce cacheline bouncing of d_count
 (Changelog@1.1024.1.11)
In-Reply-To: <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307081623100.21575@freak.distro.conectiva>
References: <16138.53118.777914.828030@charged.uio.no> 
 <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk> 
 <16138.56467.342593.715679@charged.uio.no> <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jul 2003, Alan Cox wrote:

> On Maw, 2003-07-08 at 16:00, Trond Myklebust wrote:
> > ...but I do agree with your comment. The patch I meant to refer to
> > (see revised title) does not appear in the 2.5.x tree either.
> >
> > Have we BTW been shown any numbers that support the alleged benefits?
> > I may have missed those...
>
> A while ago yes - on very big SMP boxes.
>
> Its no big problem to me since I can just back it out of -ac

Alan,

I included fastwalk patch because I thought it was a stable and very
useful optimisation. Even for 2.4. (I was expecting comments/flames on it
when I first included it.

Now if you think it is a 2.5 thing and can cause any potential problem for
2.4 I will remove it.
