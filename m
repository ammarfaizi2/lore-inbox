Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291062AbSAaNLb>; Thu, 31 Jan 2002 08:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291063AbSAaNLS>; Thu, 31 Jan 2002 08:11:18 -0500
Received: from ns.suse.de ([213.95.15.193]:26898 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291062AbSAaNLE>;
	Thu, 31 Jan 2002 08:11:04 -0500
Date: Thu, 31 Jan 2002 14:11:01 +0100
From: Dave Jones <davej@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Sebastian Dr?ge <sebastian.droege@gmx.de>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020131141101.B5948@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Oleg Drokin <green@namesys.com>,
	Sebastian Dr?ge <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130201054.6e150f78.sebastian.droege@gmx.de> <20020130201757.Q24012@suse.de> <20020131122424.A874@namesys.com> <20020131134931.A5948@suse.de> <20020131155325.A3629@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131155325.A3629@namesys.com>; from green@namesys.com on Thu, Jan 31, 2002 at 03:53:25PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 03:53:25PM +0300, Oleg Drokin wrote:
 > >  One possible is that I've goofed whilst merging Andrew Mortons
 > >  "out of disk space during truncate" fixes from 2.4.  Andrew, could
 > >  have a quick scan through the fs/ changes in -dj6 and see if anything
 > >  jumps out at you ?
 > Hm, but I remember dj6 was reported as "working"?

 -ENOTAWAKEYET. Yes, I meant -dj7 there. oops.

 > >  I'll take a look myself later too, but right now, it's a head-scratcher.
 > Do you have some place where one can see all separate patches 2.5.2-dj7 
 > consist of?

 I keep a directory named after each revision, patches get dumped there
 as I merge them, and also I dump bits of ~/Mail/merged there.
 These patches however are not always identical to what gets merged,
 as they sometimes need to be bent into shape to live with something
 else that got merged, I hand-edit the diffs to make them apply,
 sometimes removing complete hunks, and grafting that hunks intention
 into place in the source instead.
 So they're of little use to anyone in their current state, given that
 there are 'holes' where I chopped bits out.  Sometimes I rediff the
 patch afterwards, but not always.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
