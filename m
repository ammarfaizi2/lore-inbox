Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSFDSkp>; Tue, 4 Jun 2002 14:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSFDSko>; Tue, 4 Jun 2002 14:40:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11276 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316397AbSFDSkk>; Tue, 4 Jun 2002 14:40:40 -0400
Date: Tue, 4 Jun 2002 14:35:58 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: marcelo@conectiva.com.br, lmb@suse.de, linux-kernel@vger.kernel.org,
        greg@kroah.com
Subject: Re: Linux 2.4.19-pre9
In-Reply-To: <20020529.182324.44462071.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1020604142526.5024B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, David S. Miller wrote:

>    From: Marcelo Tosatti <marcelo@conectiva.com.br>
>    Date: Wed, 29 May 2002 21:34:23 -0300 (BRT)
> 
>    > > <davem@nuts.ninka.net> (02/05/06 1.383.11.22)
>    > > 	soft-fp fix:
> 
>    David, Greg, and others, please, more readable changelogs :)
>    
> I don't understand what people want in that particular kind
> of case.  I made software fp emulation fixes, four of them to
> be precise.  And on the first line I describe in general what
> I'm doing, which is soft-fp bug fixes :-)

  Sorry, no you didn't. What you didn't say was if this was a bug fix or
speedup or ??? Not trying to devalue your comment, but non-fp system are
usually embedded and do so little fp that any speedup would not matter,
while result errors matter and actual crashes would be high priority. The
line is long enough for specifying stuff like that, and gives a quick read
on the relevance of a patch. If would be useful to narrow "fix" a bit, and
I think that's what the O.P. was asking.

> sparc64 fixes:
> 
> which proceeds the actual details:
> 
> - Fix signal blah handling
> - Don't bleh during ptrace
> - Disable interrupts around foo
> - Fix IP checksum calculations when bar
> 
> Now tell me what is more appropriate on the first line and
> I'll consider it :-)

I'll suggest that "signal handling, ptrace, int disable and IP cksum" 
would fit and give a general feel for what was being addressed. That's the
flavor of what would be more useful to me, and I wouldn't mind having the
whole paragraph if that's what it takes, I read text faster than code;-) 
Like having a NIC driver "multicast icmp packet loss" is more
informational than "obscure corner case fix." 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

