Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSKKHXl>; Mon, 11 Nov 2002 02:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265631AbSKKHXl>; Mon, 11 Nov 2002 02:23:41 -0500
Received: from bbned239-32-100.dsl.hccnet.nl ([80.100.32.239]:30212 "EHLO
	vanvergehaald.nl") by vger.kernel.org with ESMTP id <S265633AbSKKHXk>;
	Mon, 11 Nov 2002 02:23:40 -0500
Date: Mon, 11 Nov 2002 00:10:17 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021111001017.J10769@vdpas.vanvergehaald.nl>
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com> <20021110145757.GK31134@suse.de> <20021110150626.GI23425@holomorphy.com> <3DCE9034.6F833C31@digeo.com> <20021110171130.GJ23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021110171130.GJ23425@holomorphy.com>; from wli@holomorphy.com on Sun, Nov 10, 2002 at 09:11:30AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 09:11:30AM -0800, William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> >> Go for it, I'm just trying to get tiobench to actually run (seems to
> >> have new/different "die from too many threads" behavior wrt. --threads).
> >> Dropping me a fresh kernel shouldn't slow anything down.
> 
> On Sun, Nov 10, 2002 at 08:58:28AM -0800, Andrew Morton wrote:
> > It could be the procps thing?  `tiobench --threads 256' shows up as a
> > single process in top and ps due to the new thread consolidation feature.
> > If you run `ps auxm' or hit 'H' in top, all is revealed.  Not my fave
> > feature that.
> 
> Turns out monitoring things via /proc/ slowed it down by some ridiculous
> factor while it was trying to spawn threads. 9 hours became less than 1s
> when I stopped looking.

Ah!
You just rediscovered the strange world of quantum physics:
the result of your experiment depends on wether you're looking or not.

:-)

-- 
 /"\                             | "I never much liked Macs.
 \ /     ASCII RIBBON CAMPAIGN   |  All the interesting stuff is hidden away."
  X        AGAINST HTML MAIL     |    --  Linus Torvalds (at the Geek Cruise)
 / \
