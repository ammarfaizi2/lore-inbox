Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129335AbRBLXUm>; Mon, 12 Feb 2001 18:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbRBLXUd>; Mon, 12 Feb 2001 18:20:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38665 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129185AbRBLXUS>; Mon, 12 Feb 2001 18:20:18 -0500
Message-ID: <3A886FAC.C47465A7@transmeta.com>
Date: Mon, 12 Feb 2001 15:20:12 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14SSCt-0008RR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Explain 'controlled buffer overrun'.
> >
> > That's probably the ability to send new data even if there's unacked old
> > data (e.g. because the receiver can't keep up or because we've had losses).
> 
> Well let me see, the typical window on the other end of the connection if
> its a normal PC class host will be 32K. I think that should be sufficient.
> 

Depends on what the client can handle.  For the kernel, that might be
true, but for example a boot loader may only have a few K worth of buffer
space.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
