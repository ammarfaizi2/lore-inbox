Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275818AbRJJOpY>; Wed, 10 Oct 2001 10:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJJOpO>; Wed, 10 Oct 2001 10:45:14 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:8210 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S275818AbRJJOpH>;
	Wed, 10 Oct 2001 10:45:07 -0400
Date: Wed, 10 Oct 2001 08:45:37 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?
Message-ID: <20011010084537.C29131@qcc.sk.ca>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011009211625Z277979-760+22927@vger.kernel.org> <3BC371B2.6010405@interactivesi.com> <1002665547.1543.123.camel@phantasy> <20011009161737.A14175@qcc.sk.ca> <1002668084.1673.137.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1002668084.1673.137.camel@phantasy>; from rml@tech9.net on Tue, Oct 09, 2001 at 06:54:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
> On Tue, 2001-10-09 at 18:17, Charles Cazabon wrote:
> > They work, but not "fine".  There are performance issues with
> > Thunderbird-core Athlons in SMP configurations that may slow them down
> > somewhat.
> 
> Are you sure it is related to SMP and not the fact the Palomino core is
> faster in general?

Yes, it's an architectural problem with the Thunderbird core.  It turns
out that in SMP configurations, the Thunderbird can actually hinder
performance in certain cases (i.e. benchmarks show very little
performance improvement for dual Thunderbirds over single Thunderbird,
while same software scales almost linearly with dual Palominos over
single Palomino).

I don't recall the exact cause, but I think it had something to do with
poor cache interaction -- cache-line ping-pong perhaps?

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
