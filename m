Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132659AbRDSS6Q>; Thu, 19 Apr 2001 14:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132660AbRDSS6G>; Thu, 19 Apr 2001 14:58:06 -0400
Received: from m9-mp1-cvx1a.col.ntl.com ([213.104.68.9]:10112 "EHLO
	[213.104.68.9]") by vger.kernel.org with ESMTP id <S132659AbRDSS5x>;
	Thu, 19 Apr 2001 14:57:53 -0400
To: Patrick Mochel <mochel@transmeta.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Next gen PM interface
In-Reply-To: <Pine.LNX.4.10.10104182122250.7690-100000@nobelium.transmeta.com>
From: John Fremlin <chief@bandits.org>
Date: 19 Apr 2001 19:57:10 +0100
In-Reply-To: <Pine.LNX.4.10.10104182122250.7690-100000@nobelium.transmeta.com>
Message-ID: <m24rvkpvjt.fsf@bandits.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Patrick Mochel <mochel@transmeta.com> writes:

> > > IMHO the pm interface should be split up as following:
> > 
> > Nobody has disagreed: therefore this separation must be perfect ;-)
> 
> I once heard that patience is a virtue. :)
> 
> > >         (1) Battery status, power status, UPS status polling. It
> > >         should be possible for lots of processes to do this
> > >         simultaneously. [That does not prohibit a single process
> > >         querying the kernel and all the others querying it.]
> > 
> > Solution. Have a bunch of procfs or dev nodes each giving info on a
> > particular power source, like now, but vaguely standardise the output.

[...]

> I can see at least two types of events - (forgive the lack of colorful
> terminology) passive and active. Passive events are simply providing
> status updates, much like the events described above. These are simply so
> some UI can notify the user of things like a low battery or detection of
> an AC adapter. These can be handled in much the same way as described
> above.

No they can't. They only happen once. Battery status exists all the
time.

[...]


-- 

	http://www.penguinpowered.com/~vii
