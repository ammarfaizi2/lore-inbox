Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBLXUM>; Mon, 12 Feb 2001 18:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRBLXUC>; Mon, 12 Feb 2001 18:20:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35593 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129144AbRBLXTs>; Mon, 12 Feb 2001 18:19:48 -0500
Message-ID: <3A886F73.759DB067@transmeta.com>
Date: Mon, 12 Feb 2001 15:19:15 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: James Sutherland <jas88@cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14SRPp-0008J1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > This is true, but one thing I'd really like to have is controlled buffer
> > overrun, which TCP *doesn't* have.  I really think an ad hoc UDP protocol
> > (I've already begun sketching on the details) is more appropriate in this
> > particular case.
> 
> Explain 'controlled buffer overrun'. BTW if you make it UDP please include
> something like SHA hash or tea hash and shared secret
> 

I *REALLY* don't know if that is reasonable; it may have to fall into the
category of "supported but not required".  Requiring an SHA hash in a
small bootstrap loader may not exactly be a reasonable expectation! 
However, I think the protocol is inherently going to be asymmetric, with
as much as possible unloaded.

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
