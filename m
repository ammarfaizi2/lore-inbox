Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSHPRLP>; Fri, 16 Aug 2002 13:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318607AbSHPRLO>; Fri, 16 Aug 2002 13:11:14 -0400
Received: from waste.org ([209.173.204.2]:2011 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318602AbSHPRLN>;
	Fri, 16 Aug 2002 13:11:13 -0400
Date: Fri, 16 Aug 2002 12:15:09 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020816171509.GJ5418@waste.org>
References: <200208151514.51462.henrique@cyclades.com> <20020815182556.GV9642@clusterfs.com> <20020815190336.GN22974@opus.bloom.county> <20020815195933.GW9642@clusterfs.com> <20020815210449.GA26993@opus.bloom.county> <20020816162802.GF5418@waste.org> <20020816170126.GD26993@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020816170126.GD26993@opus.bloom.county>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 10:01:26AM -0700, Tom Rini wrote:
> On Fri, Aug 16, 2002 at 11:28:02AM -0500, Oliver Xymoron wrote:
> 
> > What PPC and other arches really need in this area is a higher
> > resolution timing source. The jiffies-based timing is rather
> > limiting, especially after the entropy accounting stops overestimating
> > things by orders of magnitude. Does the PPC port have a convenient way
> > to access the TBR or something similar?
> 
> Not knowing i386 well, what's the TBR?  But yes, on at least some of the
> cores I know there are time registers.  I'm not sure if it's an optional
> feature for PPC or not tho.

I was actually referring to the PPC's time base register, which is
about the closest equivalent to the x86's TSC. I'm pretty sure it's a
non-optional architecture feature (but I don't have my books handy),
and I believe this usually gets wired to the clock driving the memory
bus (typically 133MHz), but I've only worked with embedded PPC so I
have no idea how it's set up in commodity hardware.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
