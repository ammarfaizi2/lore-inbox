Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136334AbRD2UeD>; Sun, 29 Apr 2001 16:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136347AbRD2Udy>; Sun, 29 Apr 2001 16:33:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:31750 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136334AbRD2Udi>; Sun, 29 Apr 2001 16:33:38 -0400
Message-ID: <3AEC7A9F.17EBEE57@transmeta.com>
Date: Sun, 29 Apr 2001 13:33:35 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Gregory Maxwell <greg@linuxpower.cx>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <200104292027.WAA25283@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> H. Peter Anvin wrote:
> > Gregory Maxwell wrote:
> > > >
> > > > I doubt the kernel is seeing it without it being there (it doesn't have
> > > > much imagination.)  However, it may very well be there in a funny
> > > > manner.  You do realize, of course, that it's pretty much impossible for
> > > > us to help you answer that question without a complete dump of the
> > > > filesystem on hand, I hope?
> > >
> > > He gave what he thought was a complete dump of the non-null bytes. The
> > > obvious answer is that he's looking wrong. :)
> > >
> >
> > Hence the "complete" part...
> 
> OK.
> 
> The image of the disk (including partition table) is at:
> 
>         ftp://ftp.bitwizard.nl/misc_junk/formatted.img.gz
> 
> It's 63kb and uncompresses to the 64Mb (almost) that it's sold as.
> 

And on at least this kernel (2.4.0) there is nothing funny about it:

: tazenda 13 ; ls -l /mnt
total 0
-r-xr-xr-x    1 root     root            0 May 23  2000 memstick.ind*
: tazenda 14 ; 

Mounting msdos, vfat or umsdos, no change.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
