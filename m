Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSGZKfD>; Fri, 26 Jul 2002 06:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317651AbSGZKdq>; Fri, 26 Jul 2002 06:33:46 -0400
Received: from p3EE3E50F.dip.t-dialin.net ([62.227.229.15]:36612 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S317649AbSGZKdT>;
	Fri, 26 Jul 2002 06:33:19 -0400
Date: Fri, 26 Jul 2002 12:25:22 +0200
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Cc: mge@sistina.com
Subject: Re: LVM 1.0.5 patch for Linux 2.4.19-rc3
Message-ID: <20020726122522.B12488@sistina.com>
Reply-To: mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 02:47:56AM +0200, Marcin Dalecki wrote:
> Christoph Hellwig wrote:
> >  
> > +#ifndef	uchar
> > +typedef	unsigned char	uchar;
> > +#endif
> > 
> > Do you _really_ have to use this non-standard type?  can't you use the
> > BSD u_char or sysv unchar?  and typedef/#define don't really mix nicely..
> 
> Or of course the normal u8 u16 and u32 and infally u64, which are so
> much more explicit about the fact that we are actually dealig with
> bit slices.
> 
> > 
> > All in all this patch would be _soooo_ much easier to review if you wouldn't
> > mix random indentation changes with real fixes.
> 
> Christoph applying the patch and rediffing with diffs "ingore white 
> space' options can help you here.
> And plese note that this kind of problems wouldn't be that common
> if we finally decided to make indent -kr -i8 mandatory.

It should have been for this patch.
Obviously an error on my end.

We'll resend...

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
