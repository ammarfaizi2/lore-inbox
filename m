Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130048AbRBMA2h>; Mon, 12 Feb 2001 19:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbRBMA21>; Mon, 12 Feb 2001 19:28:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39436 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130214AbRBMA1x>; Mon, 12 Feb 2001 19:27:53 -0500
Message-ID: <3A887F6D.5429947F@transmeta.com>
Date: Mon, 12 Feb 2001 16:27:25 -0800
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
In-Reply-To: <Pine.SOL.4.21.0102130020440.18655-100000@red.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> >
> > Well, any time there is a network there needs to be buffering, if you
> > want to have any kind of ACK protocol.
> 
> Yes, but only the last packet sent, if you limit to one packet at a
> time... Shouldn't be a problem, even for the smallest code.
> 

Of course.  Either way I was planning to use the TCP technique of ACKing
a byte position, not a packet number (unlike TFTP.)

Anyway, perhaps we should take this off linux-kernel and reconvene once
we get a sourceforge list up.

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
