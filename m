Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291049AbSAaMt5>; Thu, 31 Jan 2002 07:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291050AbSAaMts>; Thu, 31 Jan 2002 07:49:48 -0500
Received: from ns.suse.de ([213.95.15.193]:8208 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291049AbSAaMtd>;
	Thu, 31 Jan 2002 07:49:33 -0500
Date: Thu, 31 Jan 2002 13:49:31 +0100
From: Dave Jones <davej@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Sebastian Dr?ge <sebastian.droege@gmx.de>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020131134931.A5948@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Oleg Drokin <green@namesys.com>,
	Sebastian Dr?ge <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130201054.6e150f78.sebastian.droege@gmx.de> <20020130201757.Q24012@suse.de> <20020131122424.A874@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131122424.A874@namesys.com>; from green@namesys.com on Thu, Jan 31, 2002 at 12:24:24PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:24:24PM +0300, Oleg Drokin wrote:
 
 > Ok, as of now, I tried vanilla 2.5.3 and it works.

 That's something I had hoped wouldn't be the case.

 > 2.5.2-dj7 breaks instantly on the first truncate call to reiserfs.
 > I tried to dig up the difference between these 2 kernels but have not found
 > anything that will change that behaviour yet. And resierfs code is identical.
 > But dj7 seems to have a lot of modifications in the mm/* and fs/* stuff
 > compared to 2.5.3

 One possible is that I've goofed whilst merging Andrew Mortons
 "out of disk space during truncate" fixes from 2.4.  Andrew, could
 have a quick scan through the fs/ changes in -dj6 and see if anything
 jumps out at you ?

 I'll take a look myself later too, but right now, it's a head-scratcher.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
