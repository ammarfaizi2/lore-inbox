Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSKCFkU>; Sun, 3 Nov 2002 00:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSKCFkU>; Sun, 3 Nov 2002 00:40:20 -0500
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:63752 "EHLO
	skarpsey.dyndns.org") by vger.kernel.org with ESMTP
	id <S261657AbSKCFkT> convert rfc822-to-8bit; Sun, 3 Nov 2002 00:40:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
Subject: Re: AlphaPC+Sym53c8xx driver failure--solved!
Date: Sun, 3 Nov 2002 00:42:29 -0500
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211022342.29243.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved, thanks to Jay Estabrook from the debian-alpha
mailing list.  As one might guess, it turned out to my My Own
Damn Fault(tm)--I configured the kernel for LX164, then left out
"Use SRM as bootloader" because I wasn't sure I'd need it.

One thing I might change about the documentation for "Use SRM as
bootloader"--I'd probably have it mention that it should be
checked if using SRM, plus any boot loader besides MILO.  I
wasn't quite sure what it meant (silly me)--now I know better.

On Saturday 02 November 2002 06:22 am, Martin Brulisauer wrote:
> With that patch aplied I run 2.4.18 and 2.4.19
> on my alphas.
> Regards
> Martin
>
> On 1 Nov 2002, at 18:22, Kelledin wrote:
> > On Friday 01 November 2002 01:24 pm, Martin Brulisauer wrote:
> > > Did you apply the core_cia.c patch?
> > > You can find it at
> > > http://knowledge.bruli.net/uploads/core_cia-patch.txt
> >
> > Thx, I did not know about that one...
> >
> > Are there any other commonly-used patches to get 2.4 working
> > on the Alpha?  It seems Alpha support is just not seriously
> > maintained in the stock kernel...
> >
> > --
> > Kelledin
> > "If a server crashes in a server farm and no one pings it,
> > does it still cost four figures to fix?"
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to
> > majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html Please read the
> > FAQ at  http://www.tux.org/lkml/

--
Kelledin
"If a server crashes in a server farm and no one pings it, does
it still cost four figures to fix?"
