Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbSKPVpm>; Sat, 16 Nov 2002 16:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbSKPVpl>; Sat, 16 Nov 2002 16:45:41 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:13834 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267377AbSKPVpk>; Sat, 16 Nov 2002 16:45:40 -0500
Date: Sat, 16 Nov 2002 19:52:28 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021116215228.GA26275@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <20021116214140.GP24641@conectiva.com.br> <551278547.1037454258@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551278547.1037454258@[10.10.2.3]>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2002 at 01:44:19PM -0800, Martin J. Bligh escreveu:
> >> Very bad idea. People using unusual hardware do not want to keep
> >> re-submitting a bug report. I know when I submit a report I expect 
> >> that it will remain until the problem is fixed. I do not like to 
> >> receive multiple
> > 
> > Oh well, there is _no_ guarantee that it will be fixed, sometimes 
> > there is no  maintainer at all and the ticket will stay there forever 
> > lost in the noise...
> > And if anybody is interested in fixing the driver or even looking to 
> > see if somebody submitted a ticket he/she can just search for all 
> > tickets, even the ones closed because nobody is did any activity in 
> > a perior of one month (or any other timeout period).
> > 
> > Its not like the ticket will vanish from the database.
 
> One thing we've done before in other bug-tracking systems was to create
> a "STALE" state (or something similar) for this type of bug. So it 
> wouldn't get closed (I have seen this done as a closing resolution, but
> I think that's a bad idea), but it wouldn't be in the default searches
> either ... you could just select it if you wanted it ... does that sound
> sane? (obviously we don't need this yet, but might be a good plan
> longer-term).

looks sane, the idea is that automatically bugzilla would move things that
didn't had any activity to a state that doesn't appears on the default
searches, this can help with dups as well, only the most recent duplicates
would, over time, appear on the default searches. And the others would
remain in STALE mode forever. STALE for over a year? CLOSED STALE. 8) And
even then it would be in the database...

- Arnaldo
