Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262234AbRETVih>; Sun, 20 May 2001 17:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbRETViR>; Sun, 20 May 2001 17:38:17 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29702 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262240AbRETViI>;
	Sun, 20 May 2001 17:38:08 -0400
Date: Sun, 20 May 2001 18:37:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Zlatko Calusic <zlatko.calusic@iskon.hr>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105201943510.1635-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105201837240.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Mike Galbraith wrote:
> On 20 May 2001, Zlatko Calusic wrote:

> > Also in all recent kernels, if the machine is swapping, swap cache
> > grows without limits and is hard to recycle, but then again that is
> > a known problem.
> 
> This one bugs me.  I do not see that and can't understand why.

Could it be because we never free swap space and never
delete pages from the swap cache ?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

