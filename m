Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbTC0Kie>; Thu, 27 Mar 2003 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261909AbTC0Kid>; Thu, 27 Mar 2003 05:38:33 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:63722 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261896AbTC0Kid>;
	Thu, 27 Mar 2003 05:38:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wichert Akkerman <wichert@wiggy.net>
Date: Thu, 27 Mar 2003 11:49:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [FIX] Re: 2.5.66 new fbcon oops while loading X
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9CF13F6538@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 03 at 10:56, Wichert Akkerman wrote:
> Previously James Simmons wrote:
> > Only if they have more than one video card which is pretty small number.
> 
> Since when is that a relevant factor in breaking backwards
> compatibility?

All G400 and newer matroxfb users have dualhead system, so number is
not that small. Definitely not from my point of view ;-)

Problem is that Debian unstable still supports 2.2.x kernels
(kernel-image-2.2.20... & 2.2.22) and this version supports only 0/32/64/...
minors. 

So if you filled bug against makedev, you have to fill bug against 2.2.x
kernels too - either remove them or patch them, as otherwise updated
makedev has to conflict with kernels << 2.4.0.
                                                            Petr Vandrovec
                                                            

