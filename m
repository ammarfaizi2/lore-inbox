Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315464AbSEHAZQ>; Tue, 7 May 2002 20:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315467AbSEHAZP>; Tue, 7 May 2002 20:25:15 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:51639 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S315464AbSEHAZP>;
	Tue, 7 May 2002 20:25:15 -0400
Date: Wed, 8 May 2002 02:25:13 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508002513.GA26150@win.tue.nl>
In-Reply-To: <5.1.0.14.2.20020507153451.02381ec0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com> <20020507162010.GA13032@ravel.coda.cs.cmu.edu> <3CD7F212.5090608@evision-ventures.com> <20020507213603.GA18535@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 05:36:03PM -0400, Jan Harkes wrote:
> On Tue, May 07, 2002 at 05:26:10PM +0200, Martin Dalecki wrote:
> > Uz.ytkownik Jan Harkes napisa?:
> > >I'm still hoping a patch will show up that will allow me to regain
> > >access to my compactflash cards and IBM microdrive disks. The code
> > >currently doesn't rescan for new drives when a card has been inserted,
> > >although it still seems to have all the necessary logic.
> > 
> > Yes I'm fully aware of this, but the whole initialization
> > is currently much in flux and I will return to this issue back
> > if I think that things are in shape there. OK?
> 
> I thought so, you already indicated so around the time that it broke.
> There is still a 2.4 kernel when I really need to get to the data.

I usually do

	blockdev --rereadpt /dev/sde

or so. That still works for me with 2.5.13.

Andries
