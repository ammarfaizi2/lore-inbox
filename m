Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268067AbTBMPpl>; Thu, 13 Feb 2003 10:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268069AbTBMPpl>; Thu, 13 Feb 2003 10:45:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:33179 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268067AbTBMPpg>;
	Thu, 13 Feb 2003 10:45:36 -0500
Date: Thu, 13 Feb 2003 15:51:12 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 NFS FSX
Message-ID: <20030213155112.GA2070@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030213152742.GA1560@codemonkey.org.uk> <shs4r78yyjs.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs4r78yyjs.fsf@charged.uio.no>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 04:45:27PM +0100, Trond Myklebust wrote:
 > > 2.5.60's NFS seems to have various issues.  (2.5.60 client,
 > > 2.4.21pre3 server)
 > > - I ran an fsx and an fsstress in parallel.
 > >   Client rebooted after 2-3 minutes.
 > I know. There's memory corruption going on somewhere, but I'm not sure
 > exactly where.

Last thing I spotted on a serial terminal was..

RPC: garbage, exit EIO
 
 > I'm a bit confused w.r.t. both these issues. Neither occur on the
 > 2.4.x platform despite the fact that the code is more or less the
 > same. This is why I suspect an IPv4 socket problem.

ok, thanks for looking at it.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
