Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263989AbRFEOLL>; Tue, 5 Jun 2001 10:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263990AbRFEOKv>; Tue, 5 Jun 2001 10:10:51 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:33230 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S263989AbRFEOKk>; Tue, 5 Jun 2001 10:10:40 -0400
Date: Tue, 5 Jun 2001 10:10:19 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: TRG vger.timpanogas.org hacked
Message-ID: <20010605101019.A19917@alcove.wittsend.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20010604183642.A855@vger.timpanogas.org> <E157AuE-0006Wc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <E157AuE-0006Wc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 05, 2001 at 08:05:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 08:05:34AM +0100, Alan Cox wrote:
> > is curious as to how these folks did this.  They exploited BIND 8.2.3
> > to get in and logs indicated that someone was using a "back door" in 

> Bind runs as root.

	It doesn't have to.  In fact, I just set up a RedHat 6.2 Honeypot
a couple of weeks ago researching Bind based worms that are becoming
a problem.  Much to my surprise, that OOB RedHat 6.2 system ran bind
as "named -u named" and was running Bind under a common user id.  RedHat
6.0 runs it as root and I haven't checked 6.1 yet.  Don't know about the
other distros, yet.

> > We are unable to determine just how they got in exactly, but they 
> > kept trying and created an oops in the affected code which allowed 
> > the attack to proceed.  

> Are you sure they didnt in fact simply screw up live patching the kernel to
> cover their traces

	That would be a hint that they MIGHT have been trying to get a
Linux kernel stealth module going.  Several of the worms I'm looking at
include the Adore LKM to hide processes, files, and sockets.  That worm
(as several others like it) also upgrade the version of Bind they broke
in through to prevent further compromise.  There will be a security
advisory out on these worms, probably later this week.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

