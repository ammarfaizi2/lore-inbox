Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRHYQlK>; Sat, 25 Aug 2001 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRHYQlA>; Sat, 25 Aug 2001 12:41:00 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:10672 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S269763AbRHYQkw>;
	Sat, 25 Aug 2001 12:40:52 -0400
Date: Sat, 25 Aug 2001 18:41:00 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010825184100.M773@cerebro.laendle>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010825182815.K773@cerebro.laendle> <Pine.LNX.4.33L.0108251333360.5646-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108251333360.5646-100000@imladris.rielhome.conectiva>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 01:34:36PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> That wouldn't have made a big difference in this case, except that
> one process doing readahead window thrashing with its own readahead
> data would have fallen over even worse ...

I don't know that case, but in my case, one process thrashing it's
read-ahead window is twice as fats as 16 processes doing so ;)

I wother wether these problems can be fixed at all, with all these
different situations where the vm behaves totally different in (seemingly)
similar cases.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
