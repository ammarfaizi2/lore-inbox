Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbSKPVsd>; Sat, 16 Nov 2002 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbSKPVsd>; Sat, 16 Nov 2002 16:48:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28946 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267376AbSKPVsc>;
	Sat, 16 Nov 2002 16:48:32 -0500
Message-ID: <3DD6BEB2.203@pobox.com>
Date: Sat, 16 Nov 2002 16:54:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <20021116214140.GP24641@conectiva.com.br> <551278547.1037454258@[10.10.2.3]>
In-Reply-To: <20021116214140.GP24641@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> >>Very bad idea. People using unusual hardware do not want to keep
> >>re-submitting a bug report. I know when I submit a report I expect
> >>that it will remain until the problem is fixed. I do not like to
> >>receive multiple
> >
> >Oh well, there is _no_ guarantee that it will be fixed, sometimes
> >there is no  maintainer at all and the ticket will stay there forever
> >lost in the noise...
> >And if anybody is interested in fixing the driver or even looking to
> >see if somebody submitted a ticket he/she can just search for all
> >tickets, even the ones closed because nobody is did any activity in
> >a perior of one month (or any other timeout period).
> >
> >Its not like the ticket will vanish from the database.
>
>
> One thing we've done before in other bug-tracking systems was to create
> a "STALE" state (or something similar) for this type of bug. So it
> wouldn't get closed (I have seen this done as a closing resolution, but
> I think that's a bad idea), but it wouldn't be in the default searches
> either ... you could just select it if you wanted it ... does that sound
> sane? (obviously we don't need this yet, but might be a good plan
> longer-term).


Personally...  if they really are bugs, I would rather keep them open, 
even in the absence of a maintainer...   maybe that's not scalable, but 
I would rather not auto-expire things which really are bugs.  The 
maintainer (or "someone who cares") may not appear until the next stable 
series, for example.  Vendors do that alot.

'stale' may be a decent compromise if people disagree with my logic, 
though...

	Jeff



