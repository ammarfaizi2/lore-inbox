Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRCDSO3>; Sun, 4 Mar 2001 13:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRCDSOU>; Sun, 4 Mar 2001 13:14:20 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:63734 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S130485AbRCDSN7>; Sun, 4 Mar 2001 13:13:59 -0500
Date: Sun, 4 Mar 2001 15:14:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [TINY patch] VM compromise?
In-Reply-To: <Pine.LNX.4.33.0103041813280.541-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0103041513440.3078-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Mar 2001, Mike Galbraith wrote:

> Why do I think it works?
> 
> 1. kswapd attempting to fix everything in one run doesn't take
> into account that tasks not only allocate, they also free.  If
> we try to fix everything, we're usually assuring an overreaction.
> 
> 2. scanning a little more agressively brings the cache shrinkage
> to swap ratio to something more realistic for this work load..
> and I strongly suspect many others as well.

Looking great.

Alan, could you please include this in the next -ac kernel ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

