Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBLXwH>; Mon, 12 Feb 2001 18:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRBLXv4>; Mon, 12 Feb 2001 18:51:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129261AbRBLXvm>; Mon, 12 Feb 2001 18:51:42 -0500
Message-ID: <3A8876FA.EA2034D1@transmeta.com>
Date: Mon, 12 Feb 2001 15:51:22 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: James Sutherland <jas88@cam.ac.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <Pine.SOL.4.21.0102122331360.21380-100000@yellow.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> >
> > Depends on what the client can handle.  For the kernel, that might be
> > true, but for example a boot loader may only have a few K worth of buffer
> > space.
> 
> Fortunately, the bulky stuff (printk's from the booting kernel) will be
> going from the boot loader to the server, and should be buffered there
> OK until they can be processed. Only the stuff sent to the client will
> need buffering, and that should be simple keystrokes...
> 

Well, any time there is a network there needs to be buffering, if you
want to have any kind of ACK protocol.

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
