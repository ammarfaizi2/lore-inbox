Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSGVLOy>; Mon, 22 Jul 2002 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSGVLOy>; Mon, 22 Jul 2002 07:14:54 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19196 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316795AbSGVLOx>; Mon, 22 Jul 2002 07:14:53 -0400
Subject: Re: [PATCH] 2.5.27 sysctl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3BE4C7.2060203@evision.ag>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
	<3D3BE17F.3040905@evision.ag> <20020722125347.B16685@lst.de> 
	<3D3BE4C7.2060203@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:30:26 +0100
Message-Id: <1027341026.31782.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 11:56, Marcin Dalecki wrote:
> Christoph Hellwig wrote:
> > On Mon, Jul 22, 2002 at 12:42:07PM +0200, Marcin Dalecki wrote:
> > 
> >>This is making the sysctl code acutally be written in C.
> >>It wasn't mostly due to georgeous ommitted size array "forward
> >>declarations". As a side effect it makes the table structure easier to
> >>deduce.
> > 
> > 
> > Please don't remove the trailing commas in the enums.  they make adding
> > to them much easier and are allowed by gcc (and maybe C99, I'm not
> > sure).
> 
> It's an GNU-ism. If you have any problem with "adding vales", just
> invent some dummy end-value. I have a problem with using -pedantic.

You seem to have it permanently engaged 8)

If you are upset about that GNUism why doesn't your patch fix the other
GNU-isms in the same file ? Also the entire kernel is *full* of GNU C
extensions.


