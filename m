Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132969AbQKZXha>; Sun, 26 Nov 2000 18:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S133022AbQKZXhU>; Sun, 26 Nov 2000 18:37:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:32528 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S132969AbQKZXhF>; Sun, 26 Nov 2000 18:37:05 -0500
Date: Sun, 26 Nov 2000 17:03:34 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001126170334.B1787@vger.timpanogas.org>
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu> <20001126164556.B1665@vger.timpanogas.org> <3A21968B.5CDB12BF@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A21968B.5CDB12BF@haque.net>; from mhaque@haque.net on Sun, Nov 26, 2000 at 06:02:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 06:02:35PM -0500, Mohammad A. Haque wrote:
> I'd rather have Anaconda changed rather than special casing standard
> utils to account for distro handling.

Great.  Then tell RedHat to rewrite it without the need for these switches.
They will say NO.  It's a trivial change, and would save me a lot of hours
rewriting scripts.  I did it once, but if RedHat has standardized on this
set of switches, why not add them as alias commands?  It's a trivial 
patch.

Jeff

> 
> "Jeff V. Merkey" wrote:
> > 
> > Anaconda will barf and require over 850+ changes to the scripts without
> > it.  If you look at the patch, you will note that it's a silent switch
> > that's only there to avoid a noisy error message from depmod.  It
> > actually does nothing other than set a flag that also does nothing.
> > -m simply maps to -F.
> > 
> 
> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/ 
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
