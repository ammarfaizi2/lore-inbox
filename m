Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269255AbRHGS2K>; Tue, 7 Aug 2001 14:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269263AbRHGS2B>; Tue, 7 Aug 2001 14:28:01 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:52403
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S269255AbRHGS1u>; Tue, 7 Aug 2001 14:27:50 -0400
Message-ID: <031e01c11f6e$c78acab0$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Paul Bristow" <paul@paulbristow.net>
Cc: "Richard Gooch" <rgooch@ras.ucalgary.ca>,
        "Martin Wilck" <Martin.Wilck@fujitsu-siemens.com>,
        "devfs mailing list" <devfs@oss.sgi.com>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0107272127060.16993-100000@biker.pdb.fsc.net><000701c116f5$8268a820$6baaa8c0@kevin> <200107281215.f6SCFt716350@mobilix.ras.ucalgary.ca> <001001c11781$9db10a50$6baaa8c0@kevin> <3B704EC5.2090900@paulbristow.net>
Subject: Re: [PATCH]: ide-floppy & devfs
Date: Tue, 7 Aug 2001 11:28:39 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, Andre's new IDE driver subsystem will allow me to continue what I had
originally started working on, which was implementing Media Status
Notification in the ide-floppy driver, so that the drive can "intelligently"
allow/disallow media removal, and when media is removed, the /dev entries
will be kept up to date as well. This looks like all 2.5 stuff as well,
though, as I don't expect to see Andre's new IDE stuff for 2.4 any time
soon.

----- Original Message -----
From: "Paul Bristow" <paul@paulbristow.net>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: "Richard Gooch" <rgooch@ras.ucalgary.ca>; "Martin Wilck"
<Martin.Wilck@fujitsu-siemens.com>; "devfs mailing list"
<devfs@oss.sgi.com>; "Linux Kernel mailing list"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, August 07, 2001 1:25 PM
Subject: Re: [PATCH]: ide-floppy & devfs


> OK.  I am the maintainer of the code, and I will try to make sense out
> of all the patches that got submitted while I was away on holiday...
>
> BTW, I also am looking forward to 2.5 starting when we can get this
> devfs stuff really working.  I have a version of ide-floppy "working
> with devfs" on my system but it still has too many funnies.
>
> Watch this space.
>
> Paul
>
> Kevin P. Fleming wrote:
> > <snip>
> >
> >>Are you saying that the two patch conflict? If not, can someone please
> >>verify that both together are safe? Or is your patch a superset?
> >>
> >>
> >
> > Actually, the patches are complementary. However, my patch I won't be
> > continuing to work on, as the entire way that partitions are
> > read/validated/passed to devfs/etc will be changed in 2.5, and I've
already
> > forwarded this patch over to the maintainer of that code (whose name
escapes
> > my memory at the moment). So I'd say don't worry about it from the devfs
> > end, you'll see the changes once 2.5 opens and these changes get merged
in
> > to that tree.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
> --
>
> Paul
>
> Email:
> paul@paulbristow.net
> Web:
> http://paulbristow.net
> ICQ:
> 11965223
>
>
>
>

