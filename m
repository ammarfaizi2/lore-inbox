Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288093AbSAHPSl>; Tue, 8 Jan 2002 10:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288097AbSAHPSc>; Tue, 8 Jan 2002 10:18:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:41487 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288093AbSAHPSS>; Tue, 8 Jan 2002 10:18:18 -0500
Date: Tue, 8 Jan 2002 12:04:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: CaT <cat@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: netfilter oops (Was: Re: Linux 2.4.18-pre2)
In-Reply-To: <20020108042348.GB1982@zip.com.au>
Message-ID: <Pine.LNX.4.21.0201081204300.19178-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, CaT wrote:

> On Mon, Jan 07, 2002 at 09:38:17PM -0200, Marcelo Tosatti wrote:
> > Here goes pre2.
> > 
> > 
> > pre2: 
> *snip*
> 
> As I was off the net for 2 weeks I wanted to wait for the next pre
> release before reporting this bug (incase I missed something and someone
> solved it anyways). Anyhow I'm assuming it still applies to pre2 as
> there has been no mention of netfilter changes in the changelog, so...
> 
> With 18-pre1, 17-rc2 and 17-preX (can't remember now. It's been a week
> or so :/) I can get the kernel to consistantly crash after a few minutes
> by compiling it with ipchains compatability and using masqueraded net
> connections. If I connect to the getway in quetion without hitting the
> masq rules I'm fine. I can also use the net from the gateway, but if I
> try to use the net from a box behind it and that box gets masqueraded I
> get a kernel lockup and an oops after a minute or so of use. Unfortunately
> the oops doesn't actually get recorded anywhere and all I can remember
> from it is that it was dieing in 'Swapper task' (or something similar).
> 
> I did a bit more experimentation and removed all the netfilter changes
> done since 2.4.16 and I no longer got oopses so one of the changes after
> 2.4.16 broke things.
> 
> Unfortunately, I am no longer near said gateway. I -can- try and
> duplicate this as soon as I get a version of linux compiling on a debian
> woody system.
> 
> If you have any questions/requests/whatnots then please yell. If I
> succeed in duplicateing this and get a recorded oops I'll send that in
> also.

Please use a serial console to get the oops or write it down in paper.

Thanks

