Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRLLQye>; Wed, 12 Dec 2001 11:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281157AbRLLQyY>; Wed, 12 Dec 2001 11:54:24 -0500
Received: from hermes.domdv.de ([193.102.202.1]:45582 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S281129AbRLLQyJ>;
	Wed, 12 Dec 2001 11:54:09 -0500
Message-ID: <XFMail.20011212175053.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.21.0112121632440.4294-100000@chiark.greenend.org.uk>
Date: Wed, 12 Dec 2001 17:50:53 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: "Jonathan D. Amery" <jdamery@chiark.greenend.org.uk>
Subject: RE: VT82C686 && APM deadlock bug?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though not with this chipset this lockup did already appear a few times on the
list. Im my case it happened on a i815 based system. It seems that something is
going wrong during (apm?) screen blanking when there is interrupt activity.
Unfortunately the system is frozen solid so there's no chance for any debug
trace. It would be nice if someone with detail knowledge of the blanking code
could have a look.

On 12-Dec-2001 Jonathan D. Amery wrote:
> 
>  I haven't seen this reported anywhere, so apologies if you've heard this
> before :).
> 
>  in 2.4.9 and 2.4.16 with APM compiled in on my Sony Vaio FX201 laptop
> (Via VT82C686 chipset) sometimes when the hardware screensaver comes on
> (as a result of APM) the machine deadlocks and has to be powered off and
> on again.  (Lots of fscking).
> 
>  If you want any more info, please ask :).
> 
> -- 
> Jonathan Amery.      Now there's a light at the end of the tunnel,
>    #####                Someone's lit a campfire in my cave.
>   #######__o         The first rays of dawn are breaking through the clouds,
>   #######'/             And somehow I know I can be brave.      - Steve
> Kitson
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
