Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129247AbQKGKjT>; Tue, 7 Nov 2000 05:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbQKGKjI>; Tue, 7 Nov 2000 05:39:08 -0500
Received: from 4dyn176.delft.casema.net ([195.96.105.176]:8200 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129247AbQKGKiy>; Tue, 7 Nov 2000 05:38:54 -0500
Message-Id: <200011071036.LAA03845@cave.bitwizard.nl>
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <200011070958.BAA03175@pizda.ninka.net> from "David S. Miller" at
 "Nov 7, 2000 01:58:28 am"
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 7 Nov 2000 11:36:05 +0100 (MET)
CC: R.E.Wolff@BitWizard.nl, jordy@napster.com, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    Date: Tue, 7 Nov 2000 10:38:12 +0100 (MET)
>    From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
> 
>    David S. Miller wrote:
>    > It is clear though, that something is messing with or corrupting the
>    > packets.  One thing you might try is turning off TCP header
>    > compression for the PPP link, does this make a difference?
> 
>    Try specifying "asyncmap 0xffffffff" too. 
> 
> I wonder how this is specified under win98 :-)

Well, I missed the initial part of this discussion. From your remark I
must conclude that the Windows box is dialling in to an ISP and it's a
Linux box that is somewhere on the net. Then you can't just put it in
the ppp0.options on the linux box. :-(

I do suspect that there must be a popup screen on W98 that allows you
this control. Possibly it's tucked away in some "registry" entry
somewhere.

				Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
