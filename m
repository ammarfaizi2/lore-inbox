Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291145AbSBGOz5>; Thu, 7 Feb 2002 09:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291148AbSBGOzr>; Thu, 7 Feb 2002 09:55:47 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:40709 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291145AbSBGOze>;
	Thu, 7 Feb 2002 09:55:34 -0500
Date: Thu, 7 Feb 2002 12:55:20 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, <zaitcev@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The IBM order relaxation patch
In-Reply-To: <E16YpHW-0000aw-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0202071254430.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Daniel Phillips wrote:

> > This looks hard to fix with the current mm layer.  Maybe Rik's
> > rmap method could help here, because with reverse mappings we
> > can at least try to free adjacent areas (because we then at least
> > *know* who's using the pages).
>
> Yes, that's one of leading reasons for wanting rmap.  (Number one and
> two reasons are: allow forcible unmapping of multiply referenced pages
> for swapout; get more reliable hardware ref bit readings.)

It's still on my TODO list.  Patches are very much welcome
though ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

