Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267419AbRGQC2t>; Mon, 16 Jul 2001 22:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbRGQC2j>; Mon, 16 Jul 2001 22:28:39 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:13252 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S267419AbRGQC20>; Mon, 16 Jul 2001 22:28:26 -0400
Date: Mon, 16 Jul 2001 22:22:15 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, Adam <adam@eax.com>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib
Message-ID: <20010716222215.A4695@alcove.wittsend.com>
Mail-Followup-To: Alex Buell <alex.buell@tahallah.demon.co.uk>,
	Alexander Viro <viro@math.psu.edu>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>, Adam <adam@eax.com>,
	Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0107160128320.26491-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0107160727520.634-100000@tahallah.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <Pine.LNX.4.33.0107160727520.634-100000@tahallah.demon.co.uk>; from alex.buell@tahallah.demon.co.uk on Mon, Jul 16, 2001 at 07:30:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2001 at 07:30:01AM +0100, Alex Buell wrote:
> On Mon, 16 Jul 2001, Alexander Viro wrote:

> > 	Alex, could you do strace of that? It would clarify the situation.

> Unfortunately there's no working version of strace for the sparc32-linux
> platform. :o( If anyone knows better, I'd be infinitely grateful - mail me
> privately.

> As it turns out, the extraneous '..' is actually a file. I did a rm ..*,
> which left the original .. directory alone but removed the .. file. Did a
> e2fsck on reboot, no problems found.

	That's like the old game of adventure when you wave the wand and
it replies "Nothing obvious happens" just before you step into quicksand
(if you waved it an even number of times).

	You got problems.  There should be a reason for that file and it
ain't good.  It ain't good AT ALL.  It's a stock "cracker" trick for
hiding something (lame, I know).  You need to go over that system with
a fine toothed comb.  Boot from secure media, like the LinuxCare BBC
(Bootable Business Card), and sweep that sucker.  You can use rpm to
verify the packages to begin with...  Don't trust ANY executable on
the system itself.

	You HAVE to boot from other media.  Some of these suckers have
Linux kernel modules (we'll keep it a little on topic here) like Adore
and KIS that hide processes, connections, services, and files.  You can
not trust your kernel if you may have been compromised.

> -- 
> Hey, they *are* out to get you, but it's nothing personal.

	No joke...  And I do believe they done got you.

> http://www.tahallah.demon.co.uk

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

