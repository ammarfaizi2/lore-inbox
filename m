Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVBRJJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVBRJJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 04:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVBRJJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 04:09:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34373
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261305AbVBRJJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 04:09:04 -0500
Date: Fri, 18 Feb 2005 10:09:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Patrick McFarland <pmcfarland@downeast.net>, lm@bitmover.com,
       linux-kernel@vger.kernel.org, darcs-users@darcs.net
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050218090900.GA2071@opteron.random>
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421551F5.5090005@tupshin.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 06:24:53PM -0800, Tupshin Harper wrote:
> small to medium sized ones). Last I checked, Arch was still too slow in 
> some areas, though that might have changed in recent months. Also, many 

IMHO someone needs to rewrite ARCH using the RCS or SCCS format for the
backend and a single file for the changesets and with sane parameters
conventions miming SVN. The internal algorithms of arch seems the most
advanced possible. It's just the interface and the fs backend that's so
bad and doesn't compress in the backups either.  SVN bsddb doesn't
compress either by default, but at least the new fsfs compresses pretty
well, not as good as CVS, but not as badly as bsddb and arch either.

I may be completely wrong, so take the above just as a humble
suggestion.

darcs scares me a bit because it's in haskell, I don't believe very much
in functional languages for compute intensive stuff, ram utilization
skyrockets sometime (I wouldn't like to need >1G of ram to manage the
tree). Other languages like python or perl are much slower than C/C++
too but at least ram utilization can be normally dominated to sane
levels with them and they can be greatly optimized easily with C/C++
extensions of the performance critical parts.
