Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZBjd>; Thu, 25 Jan 2001 20:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131357AbRAZBjX>; Thu, 25 Jan 2001 20:39:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:50694 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129169AbRAZBjS>; Thu, 25 Jan 2001 20:39:18 -0500
Message-ID: <3A70D524.11362EFB@transmeta.com>
Date: Thu, 25 Jan 2001 17:38:44 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
		<94qcvm$9qp$1@cesium.transmeta.com> <14960.54069.369317.517425@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Secondly, the RFCs are pretty clear that the bits in question used for
> ECN are _reserved_ and to be ignored by implementations.  That means
> to not be interpreted, and more importantly not used to discard
> packets.
> 

Last I communicated with them, I looked for a reference like that in the
standards RFCs so I could quote chapter and verse at the Hotmail people,
but I couldn't find it.  If there is such a reference, someone should
point it out to them, as well as the Cisco patch you point out.  As I
said before, I have had good experience with getting them to fix things
if someone actually points the exact violation they're committing.

>  > In this case, though, they feel that they don't want to potentially
>  > destabilize their network over something that is labelled an
>  > experimental standard.  I can certainly understand their point.
> 
> That's respectible.
> 
> However, to my knowledge the fix in question is available from Cisco
> as a fully supported "safe" patch, rather than some haphazard beta
> patch.

Right, but there is a whole mythos around which version of IOS does what
without breaking something.  I can certainly understand that people are
reluctant to upgrade if they don't have to.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
