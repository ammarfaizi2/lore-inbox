Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSKSNVT>; Tue, 19 Nov 2002 08:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSKSNVT>; Tue, 19 Nov 2002 08:21:19 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:49825 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261686AbSKSNVS>;
	Tue, 19 Nov 2002 08:21:18 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Javier Marcet <jmarcet@pobox.com>
Date: Tue, 19 Nov 2002 14:28:01 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] bttv & 2.5.48
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <7F54A233BE1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 02 at 14:21, Javier Marcet wrote:
> drivers/media/video/bttv-cards.c: In function AUDC_CONFIG_PINNACLE' undeclared (first use in this function)
> drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported only once
> drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
> drivers/media/video/bttv-cards.c: In function name'
> make[4]: *** [drivers/media/video/bttv-cards.o] Error 1
> make[3]: *** [drivers/media/video] Error 2
> make[2]: *** [drivers/media] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [modules] Error 2
> 
> I know this has not changed since 2.5.47, nor couldn't spot any
> difference within the /media tree, yet it fails on 2.5.48 while it
> compiled fine on 2.5.47
> 
> Any idea where the error might be?

I just commented out that offending line, as I do not have Pinnacle,
so it should be never executed ;-)

If you have Pinnacle, then you'll have to get tda9887 driver somewhere.
This driver defines AUD_CONFIG_PINNACLE (as far as I can tell from
missing pieces...).

AFAIK bttv driver at http://bytesex.org/bttv has this fixed.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
