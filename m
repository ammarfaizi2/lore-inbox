Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269435AbRHCQEU>; Fri, 3 Aug 2001 12:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269434AbRHCQEA>; Fri, 3 Aug 2001 12:04:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:39440 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269433AbRHCQDt>;
	Fri, 3 Aug 2001 12:03:49 -0400
Date: Fri, 3 Aug 2001 13:03:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <3B6A935B.8000004@fugmann.dhs.org>
Message-ID: <Pine.LNX.4.33L.0108031303000.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Anders Peter Fugmann wrote:

> If the reason for the machine going bad is because when the running
> process eventually (or even before) gets all it memory to actually run,
> it is rescheduled, I see a simple solution.
>
> Stop rescheduling too often when memory is low. Rescheduling is very
> memory demanding (in terms of swapping and stuff), and that is not
> helping the situation.
>
> Any thought on this, or am I compleatly mistaken?

We don't know which additional memory the big task will
need until we let it run a bit and do its page fault.


Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

