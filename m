Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbRFLVBj>; Tue, 12 Jun 2001 17:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFLVB3>; Tue, 12 Jun 2001 17:01:29 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20147 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263294AbRFLVBL>;
	Tue, 12 Jun 2001 17:01:11 -0400
Message-ID: <3B26827B.5CF40115@uu.net>
Date: Tue, 12 Jun 2001 16:58:35 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I know they have not been integrated into the Xfree tree.  I
believe there were some disagreements about extending the Xv API since
GATOS added some extentions to support the AIW video capture cards.  I
suppose someone could try and submit a patch again and see if they'll
take it.  

Also there is some work on a new XvMC interface that would allow for
extended DVD acceleration.

Alex

--------------------------

On Mon, 11 Jun 2001 egger@suse.de wrote: 
> 
> On 10 Jun, Linus Torvalds wrote: 
> 
> > I've not figured out why the ATI Xv stuff from gatos seems to not have 
> > made it into the XFree86 CVS tree - it works better than much of the 
> > Xv stuff for some other chipsets that _are_ in the CVS tree. 
> > 
> > I imported it into the XFree86 CVS some months ago, it was trivial. I 
> > don't have the patches lying around any more, though. I can try to 
> > re-create them if anybody needs help. 
> 
> Did it look endiansafe to you? The ATI Xv stuff from XFree86 4.1.0 
> produces psychadelic results for me on PPC. 

I have to say that I have absolutely no idea. I only use little-endian 
machines myself (and 99% x86). 

Also, which ATI Xv stuff are you talking about? The ATI Rage128 and ATI 
Radeon Xv code was at least a few months ago completely separate from
the 
ATI Rage code (the first two were in X CVS, while the latter only
existed 
in the gatos version). 

Has the Gatos code (or some other code) maybe been integrated into 4.1.0 
now? I haven't followed X CVS for the last months very closely.. 

                Linus
