Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276647AbRKDAHe>; Sat, 3 Nov 2001 19:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276670AbRKDAHY>; Sat, 3 Nov 2001 19:07:24 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:10511 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S276647AbRKDAHK>; Sat, 3 Nov 2001 19:07:10 -0500
Date: Sun, 4 Nov 2001 01:07:03 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Thomas Lussnig <tlussnig@bewegungsmelder.de>,
        linux-kernel@vger.kernel.org,
        khttpd mailing list <khttpd-users@zgp.org>,
        Tux mailing list <tux-list@redhat.com>
Subject: Re: [khttpd-users] khttpd vs tux
Message-ID: <20011104010703.H23391@arthur.ubicom.tudelft.nl>
In-Reply-To: <E1606Lo-0006ZD-00@the-village.bc.nu> <Pine.LNX.4.30.0111032014580.9446-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0111032014580.9446-100000@mustard.heime.net>; from roy@karlsbakk.net on Sat, Nov 03, 2001 at 08:18:19PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 08:18:19PM +0100, Roy Sigurd Karlsbakk wrote:
> > Each GigE card will need its own 66MHz PCI bus. Each PCI bridge will need
> > to be coming off a memory bus that can sustain all of these and the CPU
> > at once.
> >
> > At that point it really doesnt look much like a PC.
> 
> How much raw speed do you think I can manage to get out of a really cool
> n-way server from Compaq? I beleive we'll go for a Compaq server, as
> that's what's been decided some time ago.

Not that much. Alan's point is that you're pushing the limit of the
memory bandwidth, not the number of CPUs. This is the single reason
that high traffic websites either use some serious non-PC hardware (IBM
Z-series, for example) or a large number of PCs in parallel to share
the load.

> I read something by Linus about linux scalability, and I beleive he said
> that 'linux [2.4] scales good up to 4 cpus, but not that good futher on
> [to 8?]'. Can anyone fill in the holes here?

The number of CPUs really doesn't matter in this case. With several
GigE cards memory bandwidth and latency is your main problem.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
