Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbREOGRQ>; Tue, 15 May 2001 02:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbREOGRG>; Tue, 15 May 2001 02:17:06 -0400
Received: from oss.sgi.com ([216.32.174.190]:15621 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S262649AbREOGQ5>;
	Tue, 15 May 2001 02:16:57 -0400
Date: Tue, 15 May 2001 03:06:45 -0300
From: Ralf Baechle <ralf@uni-koblenz.de>
To: God <atm@sdk.ca>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: TCP capture effect :: estimate queue length ?
Message-ID: <20010515030645.A15896@bacchus.dhis.org>
In-Reply-To: <20010514234604.A4694@gruyere.muc.suse.de> <Pine.LNX.4.21.0105142339470.23642-100000@scotch.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105142339470.23642-100000@scotch.homeip.net>; from atm@sdk.ca on Mon, May 14, 2001 at 11:49:16PM -0400
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 11:49:16PM -0400, God wrote:

> > Packets are dropped when a device queue
> > fills, and when one sender is much faster than the other the faster sender
> > often wins the race, while the packets of the slower one get dropped.
> 
> [.....]
> 
> Speaking of queues on routers/servers, does such a util exist that would
> measure (even a rough estimate), what level of congestion (queueing) is
> happening between point A and B ?  I'd be curious how badly congested some
> things upstream from me are......   I know I can use ping or
> traceroute ... but they don't report queueing or bursting.  Both measure
> latency and packetloss ... short of stareing at a running ping that is
> ... <G>

Pathchar, yet another Van Jacobsen toy does this.  Unfortunately the old
and rotten pre-version you can find in ftp.ee.lbl.gov:/pathchar/ is afaik
the last one.  In the past it served me well you find about how ISPs are
lying ...  100mbit backbone = fast ethernet in their computer room ...

  Ralf
