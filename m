Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWGTWZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWGTWZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 18:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWGTWZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 18:25:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2509 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030386AbWGTWZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 18:25:29 -0400
Date: Fri, 21 Jul 2006 08:24:49 +1000
From: Nathan Scott <nathans@sgi.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Chris Wedgwood <cw@f00f.org>, David Greaves <david@dgreaves.com>,
       Kasper Sandberg <lkml@metanurb.dk>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, ml@magog.se, radsaq@gmail.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
Message-ID: <20060721082448.C1990742@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <1153304468.3706.4.camel@localhost> <20060720171310.B1970528@wobbly.melbourne.sgi.com> <44BF8500.1010708@dgreaves.com> <20060720161121.GA26748@tuatara.stupidest.org> <20060721081452.B1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201817450.23697@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.64.0607201817450.23697@p34.internal.lan>; from jpiszcz@lucidpixels.com on Thu, Jul 20, 2006 at 06:18:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 06:18:14PM -0400, Justin Piszcz wrote:
> Nathan,
> 
> Does the bug only occur during a crash?

No, its unrelated to crashing.  Only when adding/removing from a
directory that is in a specific node/btree format (many entries),
and only under a specific set of conditions (like what directory
entry names were used, which blocks they've hashed to and how they
ended up being allocated and in what order each block gets removed
from the directory).

> I have been running 2.6.17.x for awhile now (multiple XFS filesystems, all 
> on UPS) - no issue?

Could be an issue, could be none.  xfs_check it to be sure.

cheers.

-- 
Nathan
