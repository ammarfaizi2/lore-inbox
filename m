Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132996AbQKZXTR>; Sun, 26 Nov 2000 18:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132994AbQKZXTH>; Sun, 26 Nov 2000 18:19:07 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:27920 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131530AbQKZXTC>; Sun, 26 Nov 2000 18:19:02 -0500
Date: Sun, 26 Nov 2000 16:45:56 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001126164556.B1665@vger.timpanogas.org>
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E140AZB-0002Qh-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 26, 2000 at 10:46:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 10:46:35PM +0000, Alan Cox wrote:
> > +		{"ignore-versions", 0, 0, 'i'},
> 
> I dont think we should encourage anyone to ignore symbol versions

Anaconda will barf and require over 850+ changes to the scripts without
it.  If you look at the patch, you will note that it's a silent switch
that's only there to avoid a noisy error message from depmod.  It 
actually does nothing other than set a flag that also does nothing.  
-m simply maps to -F.

:-)

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
