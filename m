Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319039AbSHSUMB>; Mon, 19 Aug 2002 16:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319040AbSHSUMA>; Mon, 19 Aug 2002 16:12:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47876 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319039AbSHSUL6>; Mon, 19 Aug 2002 16:11:58 -0400
Date: Mon, 19 Aug 2002 17:15:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: [PATCH] rmap bugfix, try_to_unmap
In-Reply-To: <E17gsiW-0000rS-00@starship>
Message-ID: <Pine.LNX.4.44L.0208191715130.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Daniel Phillips wrote:
> On Monday 12 August 2002 16:58, Rik van Riel wrote:
> >  	case SWAP_FAIL:
> >  		ret = SWAP_FAIL;
> > -		break;
> > +		goto give_up;
>
> Yes, I looked at that many times while reading the break as a 'break
> from loop' every time.  Using the same keyword to mean 'stop looping'
> and 'endcase' was, by any measure, a stupid idea.

What's even more curious is that 'continue' has the exact
same effect on 'switch' ...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

