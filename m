Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136189AbRD2UQC>; Sun, 29 Apr 2001 16:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136210AbRD2UPw>; Sun, 29 Apr 2001 16:15:52 -0400
Received: from [63.95.87.168] ([63.95.87.168]:56583 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S136189AbRD2UPp>;
	Sun, 29 Apr 2001 16:15:45 -0400
Date: Sun, 29 Apr 2001 16:15:44 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Sony Memory stick format funnies...
Message-ID: <20010429161544.A17539@xi.linuxpower.cx>
In-Reply-To: <200104292003.WAA25179@cave.bitwizard.nl> <3AEC74F2.7B219E4E@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3AEC74F2.7B219E4E@transmeta.com>; from hpa@transmeta.com on Sun, Apr 29, 2001 at 01:09:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 01:09:22PM -0700, H. Peter Anvin wrote:
> Rogier Wolff wrote:
> > 
> > H. Peter Anvin wrote:
> > > Followup to:  <200104282236.AAA06021@cave.bitwizard.nl>
> > > By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
> > > In newsgroup: linux.dev.kernel
> > > >
> > > > # l /mnt/d1
> > > > total 16
> > > > drwxr-xr-x 512 root     root        16384 Mar 24 17:26 dcim/
> > > > -r-xr-xr-x   1 root     root            0 May 23  2000 memstick.ind*
> > > > #
> > > >
> > > > Where the *(&#$%& does that "dcim" directory come from????
> > > >
> > >
> > > "dcim" probably stands for "digital camera images".  At least Canon
> > > digital cameras always put their data in a directory named dcim.
> > 
> > Yes. I know. Seems to be standard. The stick is for my Sony camera.
> > 
> > However, the question is: how in **** is the Linux kernel seeing that
> > directory while it's not on the stick? (the root directory has one
> > MEMSTICK.IND file, and nothing else!)
> > 
> 
> I doubt the kernel is seeing it without it being there (it doesn't have
> much imagination.)  However, it may very well be there in a funny
> manner.  You do realize, of course, that it's pretty much impossible for
> us to help you answer that question without a complete dump of the
> filesystem on hand, I hope?

He gave what he thought was a complete dump of the non-null bytes. The
obvious answer is that he's looking wrong. :)
