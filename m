Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbREUKon>; Mon, 21 May 2001 06:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262466AbREUKo0>; Mon, 21 May 2001 06:44:26 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:53768 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S262460AbREUKoW>; Mon, 21 May 2001 06:44:22 -0400
Date: Mon, 21 May 2001 11:42:21 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux scalability?
Message-ID: <20010521114221.B24919@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Sasi Peter <sape@iq.rulez.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010518091711.B26232@dev.sportingbet.com> <Pine.LNX.4.33.0105191026260.11903-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105191026260.11903-100000@iq.rulez.org>; from sape@iq.rulez.org on Sat, May 19, 2001 at 10:31:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup.  The problem is that you're trying to measure scalability in performance
of an i/o-bound task by comparing a machine with greater i/o resource but less
processing power with one with greater processing but poorer i/o.  Surprisingly
enough, the one with the best i/o wins.  This isn't really a fair comparison
between the two platforms.

If you put the same disk array on both machines and got the same results, then
you'd have a point.

My point was that in the real world having this configuration for a webserver
is unlikely to be sensible at all.

Sean

On Sat, May 19, 2001 at 10:31:01AM +0200, Sasi Peter wrote:
> On Fri, 18 May 2001, Sean Hunter wrote:
> 
> > Why would you want to run a web server with 8 processors rather than four
> > webservers with 2 each?
> 
> As you might already know, after the interviews to Mingo I assumed, that a
> major portion of the achievements was enabled by the 2.4 scalability
> enhacements. That is why I wrote to LKML, to ask about the 2.4
> scalability, if anybody out there could tell us about the linux kernel's
> scalability possibily compared to W2k scalability...
> 
> -- 
> SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
