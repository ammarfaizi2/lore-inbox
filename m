Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129788AbQKCAj1>; Thu, 2 Nov 2000 19:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130122AbQKCAjR>; Thu, 2 Nov 2000 19:39:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129788AbQKCAjH>; Thu, 2 Nov 2000 19:39:07 -0500
Message-ID: <3A020923.7815E495@transmeta.com>
Date: Thu, 02 Nov 2000 16:38:59 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: select() bug
In-Reply-To: <E13rTfB-00023L-00@the-village.bc.nu> <3A01FC44.8A43FE8B@iname.com> <8tsupp$gh8$1@cesium.transmeta.com> <200011022346.PAA01451@pizda.ninka.net> <3A0200F5.2D6F4F70@transmeta.com> <200011022352.PAA02403@pizda.ninka.net> <3A020319.3384D4FF@transmeta.com> <200011030005.QAA03942@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Thu, 02 Nov 2000 16:13:13 -0800
>    From: "H. Peter Anvin" <hpa@transmeta.com>
> 
>    Oh.  What do you do if there isn't... link up the contents of the
>    write() in a kiovec and hold the writer?
> 
> Right, the writer blocks.
> 
> I've already posted the patches here within the past week, I'll send
> them to you under seperate cover so you can see for yourself how it
> works.
> 

Sure, but my point was that it would be nice for high-traffic pipes to
allow a larger volume of data with the two processes still running
concurrently.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
