Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291705AbSBNOwB>; Thu, 14 Feb 2002 09:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291693AbSBNOvs>; Thu, 14 Feb 2002 09:51:48 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:23525 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S291704AbSBNOvf>; Thu, 14 Feb 2002 09:51:35 -0500
Date: Thu, 14 Feb 2002 06:51:26 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc1
In-Reply-To: <Pine.NEB.4.44.0202141404210.25879-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0202140647040.12772-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Adrian Bunk wrote:

> On Wed, 13 Feb 2002, Marcelo Tosatti wrote:
>
> > So here it goes.
> >
> > rc1:
> >...
> > - Merge some -ac bugfixes			(Alan Cox)
> >
> > pre9:
> >...
> > - Add framebuffer support for trident graphics
                      ^^^^^^^
> >   card						(James Simmons)
> >...
>
> These two changes together result in the fact that there's now a
> CONFIG_FB_TRIDENT but if you try to enable it compilation fails with a
>
>   tridentfb.c:524: #error "Floating point maths. This needs fixing before
>   the driver is safe"
>
> which makes it pretty useless. Since this is a stable kernel series I want
> to suggest that if there's no fix for this before 2.4.18-final to remove
> the trident support from 2.4.18 and to re-add it in 2.4.19-pre1 (with
> the hope that it will be fixed before 2.4.19-final).

Seems to me if the module doesn't compile then the term "support" above
is incorrect. So ... do you fix it or remove it. What does James Simmons
have to say about this?
-- 
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

How to Stop A Folksinger Cold # 2
"Are you going to Scarborough Fair?..."
No.

