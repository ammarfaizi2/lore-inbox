Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbRGQMdp>; Tue, 17 Jul 2001 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266277AbRGQMdg>; Tue, 17 Jul 2001 08:33:36 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:51407 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S266271AbRGQMd0>; Tue, 17 Jul 2001 08:33:26 -0400
Date: Tue, 17 Jul 2001 08:33:18 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
Cc: "Michael H. Warfield" <mhw@wittsend.com>,
        Alexander Viro <viro@math.psu.edu>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, Adam <adam@eax.com>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib
Message-ID: <20010717083318.B4692@alcove.wittsend.com>
Mail-Followup-To: Alex Buell <alex.buell@tahallah.demon.co.uk>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	Alexander Viro <viro@math.psu.edu>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>, Adam <adam@eax.com>,
	Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010716222215.A4695@alcove.wittsend.com> <Pine.LNX.4.33.0107171123320.3591-100000@tahallah.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <Pine.LNX.4.33.0107171123320.3591-100000@tahallah.demon.co.uk>; from alex.buell@tahallah.demon.co.uk on Tue, Jul 17, 2001 at 11:26:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2001 at 11:26:58AM +0100, Alex Buell wrote:

> I'm just wondering how they managed to get in given that I never download
> binaries and always compile from sources myself. Probably through a
> compromised TCP/IP service, I bet.

	That would be a good guess.  Without knowing what distribution
you are on and what services you are running, it's impossible to guess.
But there aren't too many out there that don't have something and all
of them have have security updates even for the latest distros.  I just
got done researching a couple of DNS worms that are taking advantage
of Bind 8.2.2 and earlier.  They probe through DNS only and are massively
scanning the entire IPv4 address space.  In three weeks I saw over
30,000 probes into a /19 monitored address space from over 3,000 unique
compromised hosts.  At that probing level, it's almost impossible NOT
to get poked by one of those suckers sooner or later.  A lot of others
are scanning for port 111 (sun_rpc) or port 515 (lp) and there have been
a raft of problems in ftp.  All of these are being automatically scanned
for and even slow dial-ups are going to get hit sooner or later.

	It's gotten decidedly MORE hostile out there in the last year or
two with the appearance of these scripted worms, like Ramen, L1on, and TSIG,
that people can just tack more exploits onto and release in the wild.

> -- 
> Hey, they *are* out to get you, but it's nothing personal.

> http://www.tahallah.demon.co.uk

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

