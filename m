Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268339AbTBNKI1>; Fri, 14 Feb 2003 05:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268343AbTBNKI1>; Fri, 14 Feb 2003 05:08:27 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:55205 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268339AbTBNKIZ>;
	Fri, 14 Feb 2003 05:08:25 -0500
Date: Fri, 14 Feb 2003 10:13:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.60-mm2
Message-ID: <20030214101356.GA17155@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030214013144.2d94a9c5.akpm@digeo.com> <20030214093856.GC13845@codemonkey.org.uk> <20030214015802.66800166.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214015802.66800166.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 01:58:02AM -0800, Andrew Morton wrote:

 > > I'm puzzled that you've had NFS stable enough to test these.
 > This was just writing out a single 400 megabyte file with `dd'.  I didn't try
 > anything fancier.

ok. Can you hold off pushing NFS bits to Linus until this gets
pinned down ? I really don't want to introduce any more variables
to this, especially when its so hard to pin down to an exact
replication scenario.

Trond thinks this could be not just NFS related but something
lurking deeper within net/   which could be even more annoying
to pin down, though I don't see any other odd network related
behaviour.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
