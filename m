Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVLORQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVLORQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVLORQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:16:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:15276 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750789AbVLORQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:16:46 -0500
Date: Thu, 15 Dec 2005 17:16:45 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051215171645.GY27946@ftp.linux.org.uk>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512151258200.1605@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 01:00:05PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Dec 2005, Al Viro wrote:
> 
> > another compile fix, pulled straight from m68k CVS
> 
> Thanks, but if you pull changes out of CVS could you please keep the 
> author intact? CVS may be bad, but it's not that bad.

CVS users, OTOH...
   Mon Oct 22 09:34:34 2001 UTC (4 years, 1 month ago) by zippel
   Branches: MAIN
   CVS tags: m68k-2_5_9, m68k-2_5_8, m68k-2_5_7, m68k-2_5_65,
[snip]
   m68k-2_4_13, m68k-2_4_12
   Branch point for: m68k-2_4
   Diff to previous 1.1: preferred, colored
   Changes since revision 1.1: +1 -0 lines
import Geert's 2.4.12 m68k patch

and the same for drivers/macintosh part.

So who should I put as the author?  You or Geert (or whatever attributions
might have been in said big patch)?  Incidentally,  ADBREQ_RAW had leaked
into mainline (sans definition) in 2.3.45-pre2, which was Feb 13 2000, i.e.
more than 1.5 year before your commit, so there's quite a chunk of history
missing...

I'm serious, BTW - I certainly would have no problem preserving attribution,
but it simply hadn't been there.  CVS logs are only as good as the data
being put there by committers...
