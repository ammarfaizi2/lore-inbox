Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbRBMA0h>; Mon, 12 Feb 2001 19:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130051AbRBMA01>; Mon, 12 Feb 2001 19:26:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129752AbRBMA0U>; Mon, 12 Feb 2001 19:26:20 -0500
Message-ID: <3A887F17.BA083B28@transmeta.com>
Date: Mon, 12 Feb 2001 16:25:59 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14ST3g-000094-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'm sure you can.  That doesn't mean it's the right solution.
> 
> And the UDP proposal will be at least as big if it does retransmits, and if
> it doesnt , its junk. It will also need as much buffering, if not the same
> packing trick
> 

Within limits, you're right, of course.  I suspect it won't be *as* big
(especially not if it's talking to a PXE card which does the IP and UDP
layers in firmware, but not TCP), but I still suspect better tradeoffs
can be made this way.

That being said, I'll look at TCP as well.

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
