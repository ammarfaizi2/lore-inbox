Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136156AbRD2UKC>; Sun, 29 Apr 2001 16:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136189AbRD2UJw>; Sun, 29 Apr 2001 16:09:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136178AbRD2UJi>; Sun, 29 Apr 2001 16:09:38 -0400
Message-ID: <3AEC74F2.7B219E4E@transmeta.com>
Date: Sun, 29 Apr 2001 13:09:22 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <200104292003.WAA25179@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> H. Peter Anvin wrote:
> > Followup to:  <200104282236.AAA06021@cave.bitwizard.nl>
> > By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
> > In newsgroup: linux.dev.kernel
> > >
> > > # l /mnt/d1
> > > total 16
> > > drwxr-xr-x 512 root     root        16384 Mar 24 17:26 dcim/
> > > -r-xr-xr-x   1 root     root            0 May 23  2000 memstick.ind*
> > > #
> > >
> > > Where the *(&#$%& does that "dcim" directory come from????
> > >
> >
> > "dcim" probably stands for "digital camera images".  At least Canon
> > digital cameras always put their data in a directory named dcim.
> 
> Yes. I know. Seems to be standard. The stick is for my Sony camera.
> 
> However, the question is: how in **** is the Linux kernel seeing that
> directory while it's not on the stick? (the root directory has one
> MEMSTICK.IND file, and nothing else!)
> 

I doubt the kernel is seeing it without it being there (it doesn't have
much imagination.)  However, it may very well be there in a funny
manner.  You do realize, of course, that it's pretty much impossible for
us to help you answer that question without a complete dump of the
filesystem on hand, I hope?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
