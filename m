Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283770AbRLTKXB>; Thu, 20 Dec 2001 05:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283718AbRLTKWw>; Thu, 20 Dec 2001 05:22:52 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:50351 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S283770AbRLTKWj>;
	Thu, 20 Dec 2001 05:22:39 -0500
Date: Thu, 20 Dec 2001 11:22:18 +0100
From: David Weinehall <tao@acc.umu.se>
To: Stevie O <stevie@qrpff.net>
Cc: "David S. Miller" <davem@redhat.com>, Mika.Liljeberg@welho.com,
        kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Message-ID: <20011220112218.X5235@khan.acc.umu.se>
In-Reply-To: <3C1FA558.E889A00D@welho.com> <200112181837.VAA10394@ms2.inr.ac.ru> <3C1FA558.E889A00D@welho.com> <20011218.122813.63057831.davem@redhat.com> <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>; from stevie@qrpff.net on Thu, Dec 20, 2001 at 02:31:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:31:44AM -0500, Stevie O wrote:
> At 12:28 PM 12/18/2001 -0800, David S. Miller wrote:
> >Unaligned kernel loads and stores must be properly handled by the
> >platform code, and on ARM chips where that is possible it is.
> 
> I don't know what arch you're using, but I work with ARM7TDMI, which
> has a behavior I believe can be found documented in some obscure .pdf
> from arm.com:

Last time I checked, the ARM7tdmi was a mmu-less cpu -> ucLinux.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
