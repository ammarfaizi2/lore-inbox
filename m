Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKHNxw>; Wed, 8 Nov 2000 08:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbQKHNxm>; Wed, 8 Nov 2000 08:53:42 -0500
Received: from cerberus.s2k.com ([204.176.206.253]:44551 "EHLO
	cerberus.s2k.com") by vger.kernel.org with ESMTP id <S129181AbQKHNxX>;
	Wed, 8 Nov 2000 08:53:23 -0500
Subject: Re: Installing kernel 2.4
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFE1DF3190.2EF12079-ON85256991.004BD0EB@infinium.com>
Date: Wed, 8 Nov 2000 08:49:15 -0500
X-MIMETrack: Serialize by Router on WHQNTSE1/Infinium Software(Release 5.0.4 |June 8, 2000) at
 11/08/2000 08:49:17 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
From: Bruce_Holzrichter@infinium.com
Cc: davej@suse.de, jmerkey@vger.timpanogas.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> On Wed, Nov 08, 2000 at 03:25:56AM +0000, davej@suse.de wrote:
> > On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> >
> > > If the compiler always aligned all functions and data on 16 byte
> > > boundries (NetWare)  for all i386 code, it would run a lot faster.
> >
> > Except on architectures where 16 byte alignment isn't optimal.
> >
> > > Cache line alignment could be an option in the loader .... after all,
> > > it's hte loader that locates data in memory.  If Linux were PE based,
> > > relocation logic would be a snap with this model (like NT).
> >
> > Are you suggesting multiple files of differing alignments packed into
> > a single kernel image, and have the loader select the correct one at
> > runtime ? I really hope I've misinterpreted your intention.
>
> Or more practically, a smart loader than could select a kernel image
> based on arch and auto-detect to load the correct image. I don't really
> think it matters much what mechanism is used.
>
> What makes more sense is to pack multiple segments for different
> processor architecures into a single executable package, and have the
> loader pick the right one (the NT model).  It could be used for
> SMP and non-SMP images, though, as well as i386, i586, i686, etc.


And this would fit on my 1.4bm floppy so I can boot my hard driveless
firewalling system, correct?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
