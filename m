Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271789AbRHUSdk>; Tue, 21 Aug 2001 14:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271790AbRHUSdb>; Tue, 21 Aug 2001 14:33:31 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:46351 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S271789AbRHUSdO>; Tue, 21 Aug 2001 14:33:14 -0400
Message-Id: <200108211833.f7LIXHY96688@aslan.scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P) 
In-Reply-To: Your message of "Tue, 21 Aug 2001 19:55:25 +0200."
             <20010821195525.05d0f8bf.skraw@ithnet.com> 
Date: Tue, 21 Aug 2001 12:33:17 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And what may be of big interest for Justin: I am using the _old_ AIC7xxx
>driver. 

That doesn't surprise me.  The IA64 port had similar issues until I added
39bit addressing support to the aic7xxx driver.  Unfortunately the x86 port
doesn't support passing large dma addresses to drivers so bouncing is required
in order to do PAE.

--
Justin
