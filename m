Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129313AbQKCAEc>; Thu, 2 Nov 2000 19:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbQKCAEW>; Thu, 2 Nov 2000 19:04:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8198 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129313AbQKCAEO>; Thu, 2 Nov 2000 19:04:14 -0500
Message-ID: <3A0200F5.2D6F4F70@transmeta.com>
Date: Thu, 02 Nov 2000 16:04:05 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: select() bug
In-Reply-To: <E13rTfB-00023L-00@the-village.bc.nu> <3A01FC44.8A43FE8B@iname.com> <8tsupp$gh8$1@cesium.transmeta.com> <200011022346.PAA01451@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: "H. Peter Anvin" <hpa@zytor.com>
>    Date:        2 Nov 2000 15:53:29 -0800
> 
>    Has anyone considered the possibility of expanding the buffer of
>    high-traffic pipes?
> 
> The kiobuf pipe patches are a more effective performance improvement
> for this type of usage.  It has the benefit of not requiring a
> temporary kernel buffer of any size :-)
> 

That's (very) nice, but it does assume there is currently a reader
listening.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
