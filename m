Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbRGSOLX>; Thu, 19 Jul 2001 10:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267563AbRGSOLN>; Thu, 19 Jul 2001 10:11:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:14600 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267558AbRGSOK6>;
	Thu, 19 Jul 2001 10:10:58 -0400
Date: Thu, 19 Jul 2001 11:10:53 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Dave McCracken <dmc@austin.ibm.com>, Dirk Wetter <dirkw@rentec.com>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.21.0107182037410.8813-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0107191059460.13351-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 18 Jul 2001, Marcelo Tosatti wrote:

> Still able to trigger the problem with the GFP_HIGHUSER patch applied.

Hrrm, maybe the fact that the free target in the DMA zone is
four times higher than in the other zones has something to do
with the unbalance...

I'll try to fix the cause of this out-of-balance zone pressure
thing when I get back to Curitiba after the weekend. Your new
code to deal with the problem when it happens looks nice, btw.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

