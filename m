Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270816AbRHNU3x>; Tue, 14 Aug 2001 16:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270808AbRHNU3o>; Tue, 14 Aug 2001 16:29:44 -0400
Received: from net2.ameuro.de ([62.208.90.8]:37350 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S270816AbRHNU3d>;
	Tue, 14 Aug 2001 16:29:33 -0400
Message-ID: <3B798A34.FC105F29@alarsen.net>
Date: Tue, 14 Aug 2001 22:29:18 +0200
From: Anders Larsen <anders@alarsen.net>
Organization: syst.eng. A.Larsen (http://www.alarsen.net/)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: PinkFreud <pf-kernel1@mirkwood.net>, linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net> <E15WHVE-0007N6-00@the-village.bc.nu> <20010814205101.A11997@errol.alarsen.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Larsen wrote:
> 
> On 2001-08-13 15:11 Alan Cox wrote:
> > > emergency sync) when attempting to use 'ls' on a mounted QNX filesystem
> > > (ls comes up fine, then system crashes - nothing sent to syslog, no errors
> > > on screen, nothing!) - and this latest is with 2.4.8!
> >
> > The qnxfs code is experimental - so I can believe it might fail in 2.4. I'd
> > be very interested in info on that one.
> 
> The qnxfs code is really quite stable - that's the first time in more than a
> year that I hear of any problem reading a qnx file-system; actually, I've been
> considering removing the 'experimental' tag, but now I'll reconsider...

Come to think of it...
Mike didn't mention any details of the hardware where he's experiencing this
bug, but is it possibly a multiprocessor machine?
Since I only have UP's to test on, the qnxfs might have SMP issues.

Could someone please glance through the code in fs/qnx4 to check if there
are any obvious problems?

cheers
  Anders (maintainer, qnx4fs)
-- 
"In theory there is no difference between theory and practice.
 In practice there is." - Yogi Berra
