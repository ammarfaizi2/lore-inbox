Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbTCNEAc>; Thu, 13 Mar 2003 23:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbTCNEAb>; Thu, 13 Mar 2003 23:00:31 -0500
Received: from bitmover.com ([192.132.92.2]:31365 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263238AbTCNEAa>;
	Thu, 13 Mar 2003 23:00:30 -0500
Date: Thu, 13 Mar 2003 20:11:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (linux 2.4)
Message-ID: <20030314041114.GQ7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030312154759.GB13792@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312154759.GB13792@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 07:47:59AM -0800, Larry McVoy wrote:
> >     mkdir ws
> >     cd ws
> >     cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs co linux-2.5
> > 
> > Each of the releases are tagged, they are of the form v2_5_64 etc.
> 
> This now works for linux-2.4 as well.

New exports of 2.4 and 2.5 are up.  They should have more accurate 
users on the deltas.  Please take a look at a file you know you 
have modified and compare it the BK tree.  For example compare

cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs rlog linux-2.5/Makefile
http://linux.bkbits.net:8080/linux-2.5/hist/Makefile

I think they are closer now, let me know if you find a bug.

I have the tarballs of the RCS files available as well, let me know if you
want them.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
