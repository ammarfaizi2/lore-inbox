Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131975AbRAFADw>; Fri, 5 Jan 2001 19:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRAFADo>; Fri, 5 Jan 2001 19:03:44 -0500
Received: from pm3-5-23.apex.net ([209.250.41.38]:52998 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131975AbRAFAD2>; Fri, 5 Jan 2001 19:03:28 -0500
Date: Fri, 5 Jan 2001 18:03:50 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] random squeaks with cmpci & 2.4.0
Message-ID: <20010105180349.A6180@hapablap.dyn.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While playing mp3's on XMMS, I get squeaks at random intervals.  It
seems to correlate slightly with disk usage, but other than that it
seems random.  These squeaks did not occur with 2.4.0-prerelease, and no
changes to the cmpci driver have occurred between -prerelease and
-final.  Was there an interface/semantics change somewhere?  The only
change I see directly related to sound is in sound_timer.c, and it was
only to add a semicolon to an empty label.  Perhaps related to the VM
changes somehow?  The system is an AMD-K6/2 with 64MB ram, and running X
4.0.2 is that makes any difference.

Another interesting sidenote is that the squeaks appear as a spike in
XMMS' "Visual Analyzer" (usually a series of bars to the left of the
track information).  Could it be that this is a /userspace/ issue?
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
