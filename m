Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSJXTbU>; Thu, 24 Oct 2002 15:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265617AbSJXTbU>; Thu, 24 Oct 2002 15:31:20 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:36747 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265612AbSJXTbT>;
	Thu, 24 Oct 2002 15:31:19 -0400
Date: Thu, 24 Oct 2002 20:38:42 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Daniel Egger <degger@fhm.edu>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024193842.GA12642@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Daniel Egger <degger@fhm.edu>, linux-kernel@vger.kernel.org,
	arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com> <1035483003.5680.13.camel@sonja.de.interearth.com> <3DB849EF.1050904@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB849EF.1050904@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 09:28:47PM +0200, Manfred Spraul wrote:
 > Daniel Egger wrote:
 > 
 > >Being interested in seeing how the Via Ezra system here performs I also
 > >ran it there but experienced three segfaults in the last three tests; 
 > >two of which I can explain, but no_prefetch is a stranger right now.
 > >Anyway:
 > >
 > It seems the via cpu doesn't support prefetchnta. Could you try the 
 > attached version?

More likely its barfing on the movntq.
The VIA Ezra CPUs only have 3dnow.
Ezra-T has 3dnowext iirc.
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
