Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRBLXyG>; Mon, 12 Feb 2001 18:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbRBLXx5>; Mon, 12 Feb 2001 18:53:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1291 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129268AbRBLXxm>; Mon, 12 Feb 2001 18:53:42 -0500
Message-ID: <3A887777.3895D3F8@transmeta.com>
Date: Mon, 12 Feb 2001 15:53:27 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14SSNw-0008To-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Depends on what the client can handle.  For the kernel, that might be
> > true, but for example a boot loader may only have a few K worth of buffer
> > space.
> 
> That same constraint is true of any UDP protocol too, and indeed any protocol
> not entirely based on FEC (which rather rules out ethernet based solutions)
> 
> You also dont need much buffering for a smart embedded stack, its no secret
> that some embedded tcps dont buffer the data but pointers to constant data and
> values for only non constant objects. You really can make a minimal TCP very
> low resource.
> 

I'm sure you can.  That doesn't mean it's the right solution.

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
