Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130073AbQKZXdK>; Sun, 26 Nov 2000 18:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130767AbQKZXcu>; Sun, 26 Nov 2000 18:32:50 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:47340 "EHLO
        smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S130073AbQKZXcs>; Sun, 26 Nov 2000 18:32:48 -0500
Message-ID: <3A21968B.5CDB12BF@haque.net>
Date: Sun, 26 Nov 2000 18:02:35 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu> <20001126164556.B1665@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd rather have Anaconda changed rather than special casing standard
utils to account for distro handling.

"Jeff V. Merkey" wrote:
> 
> Anaconda will barf and require over 850+ changes to the scripts without
> it.  If you look at the patch, you will note that it's a silent switch
> that's only there to avoid a noisy error message from depmod.  It
> actually does nothing other than set a flag that also does nothing.
> -m simply maps to -F.
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
