Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135182AbRDLNGZ>; Thu, 12 Apr 2001 09:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135184AbRDLNGP>; Thu, 12 Apr 2001 09:06:15 -0400
Received: from smtp4vepub.gte.net ([206.46.170.25]:64631 "EHLO
	smtp4ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S135182AbRDLNGF>; Thu, 12 Apr 2001 09:06:05 -0400
Message-ID: <3AD5A7C4.D740ED74@neuronet.pitt.edu>
Date: Thu, 12 Apr 2001 09:04:04 -0400
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Chris Meadors <clubneon@hereintown.net>, linux-kernel@vger.kernel.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [PATCH] matroxfb and mga XF4 driver coexistence...
In-Reply-To: <4BEDDEE649D@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> On 11 Apr 01 at 14:55, Chris Meadors wrote:
> >
> > I would like to see this fixed as much as anyone (even complained to the
> > XFree people from SuSE last ALS).  But I don't think the fix should be in
> > the kernel.  XF4 needs to be fixed.  The problem doesn't just effect the
> > maxtroxfb, but also the vgacon video mode selection.
> 
> But only users using matroxfb complains to me and/or to linux-kernel ;-)
> You know, it worked last week, but it does not work anymore today. And
> only thing I changed was kernel. So it must be in kernel...
> 
> > If I put anything other than "normal" or "extended" in the "vga=" line of
> > my lilo.conf the machine starts okay, but upon exiting X bad stuff
> 
> It is first time I see that other drivers than mga one has troubles.

I think he's referrig to the matrox cards. I have mentioned this
happening to me in this list. I've a G450, if I use anything other than
'normal', going in and out of X makes my text console go blank. I don't
use the frame buffer, by the way.
 
> > I don't use the matroxfb driver so this patch wouldn't help me, and is
> > also why I say XFree 4.0 needs to be fixed.
> 
> Buy matrox and use matroxfb. It will fix problem for you, then...

If the problem occurs whithout the frame buffer on, the problem seems to
be on the X server.
-- 
     Rafael
