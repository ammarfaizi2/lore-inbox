Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSKSODA>; Tue, 19 Nov 2002 09:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSKSODA>; Tue, 19 Nov 2002 09:03:00 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:23715 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S265333AbSKSOC7>;
	Tue, 19 Nov 2002 09:02:59 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Javier Marcet <jmarcet@pobox.com>
Date: Tue, 19 Nov 2002 15:09:26 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] bttv & 2.5.48
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <7F5FAC8018B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 02 at 14:55, Javier Marcet wrote:
> >> drivers/media/video/bttv-cards.c: In function AUDC_CONFIG_PINNACLE' undeclared (first use in this function)
> >> drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported only once
> >> drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
> >> drivers/media/video/bttv-cards.c: In function name'
> >> make[4]: *** [drivers/media/video/bttv-cards.o] Error 1
> >> make[3]: *** [drivers/media/video] Error 2
> >> make[2]: *** [drivers/media] Error 2
> >> make[1]: *** [drivers] Error 2
> >> make: *** [modules] Error 2
> >> 
> >> I know this has not changed since 2.5.47, nor couldn't spot any
> >> difference within the /media tree, yet it fails on 2.5.48 while it
> >> compiled fine on 2.5.47
>  
> >> Any idea where the error might be?
> 
> >I just commented out that offending line, as I do not have Pinnacle,
> >so it should be never executed ;-)
> 
> That's the first thing I did, but how's that it compiled fine in 2.5.47
> if nothing changed?

It did not for me... I have commented it out at least since 2.5.46-c929,
from Nov 8th.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
