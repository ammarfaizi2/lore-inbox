Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130413AbRBCAQZ>; Fri, 2 Feb 2001 19:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRBCAQQ>; Fri, 2 Feb 2001 19:16:16 -0500
Received: from gaia.euronet.nl ([194.134.0.10]:28405 "HELO pop1.euronet.nl")
	by vger.kernel.org with SMTP id <S130413AbRBCAQE>;
	Fri, 2 Feb 2001 19:16:04 -0500
Message-ID: <008301c08d76$7521ca60$1500a8c0@infernix>
From: "infernix" <infernix@infernix.nl>
To: "Kai Germaschewski" <kai@thphy.uni-duesseldorf.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10102021816460.15155-100000@chaos.thphy.uni-duesseldorf.de>
Subject: Re: isdn_ppp.c bug (isdn_lzscomp.c aka STAC compression > oops on 2.4.x)
Date: Sat, 3 Feb 2001 01:15:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Unfortunately you are too right. It appears that the "!!!HACK,HACK,HACK!!!
2048 is only assumed" line is gone in 2.4.1, but is back in 2.4.1-ac1. Can
this be fixed?

Regards,

infernix

----- Original Message -----
From: "Kai Germaschewski" <kai@thphy.uni-duesseldorf.de>
To: "infernix" <infernix@infernix.nl>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, February 02, 2001 6:18 PM
Subject: Re: isdn_ppp.c bug (isdn_lzscomp.c aka STAC compression > oops on
2.4.x)


>
> On Fri, 2 Feb 2001, infernix wrote:
>
> > However, the patch hasn't been implemented yet, neither in 2.4.1 or in
> > 2.4.1-ac1, because the obvious "HACK,HACK,HACK" sentence is still
present :)
> > Could someone see to it that this mail reaches the kernel's isdn_ppp.c
> > maintainer and get this thing moving? Thanks.
>
> Look again. The patch you quoted is in patch-2.4.1.bz2. Don't know about
> 2.4.1-ac1. (But I doubt it's reverted there :)
>
> --Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
