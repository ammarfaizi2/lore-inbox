Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135367AbRDVH4Y>; Sun, 22 Apr 2001 03:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135507AbRDVH4O>; Sun, 22 Apr 2001 03:56:14 -0400
Received: from gate.mesa.nl ([194.151.5.70]:57870 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S135367AbRDVHz7>;
	Sun, 22 Apr 2001 03:55:59 -0400
Date: Sun, 22 Apr 2001 09:55:38 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Victor Julien <v.p.p.julien@let.rug.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
Message-ID: <20010422095538.A16395@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <01042118044700.01268@victor> <E14r6ax-0004Xw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14r6ax-0004Xw-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 22, 2001 at 12:15:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 12:15:13AM +0100, Alan Cox wrote:
> > I have a problem with kernels higher than 2.4.2, the sound distorts when 
> > playing a song with xmms while the seti@home client runs. 2.4.2 did not have 
> > this problem. I tried 2.4.3, 2.4.4-pre5 and 2.4.3-ac11. They al showed the 
> > same problem.
> 
> The 2.4.3->2.4.3-ac kernels include workarounds for the VIA chipset corruption
> reports. It is possible these have an impact, paticularly if the programs are
> making heavy use of X11.

I noticed that X11 became teribly slow on screen updates using 2.4.3-ac11 on
an asus a7v133 (via686b).
Before that I ran an a7v (via686a): using ac6 worked
fine with X. X on ac9 also works fine, at least I did not notice any slowdown.
Unfortunately cannot test ac11 on the a7v anymore...

I thought ac9 does include the via workarounds.  Is there a significant
diff between ac9 and ac11, or between via686a and 686b to cause this?

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number, so they gave me a name!
                                -- Rupert Hine       http://www.ruperthine.com/

