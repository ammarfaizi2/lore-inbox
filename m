Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWGTXUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWGTXUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWGTXUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:20:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44241 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030410AbWGTXUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:20:20 -0400
Date: Fri, 21 Jul 2006 09:19:45 +1000
From: Nathan Scott <nathans@sgi.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>, Chris Wedgwood <cw@f00f.org>
Cc: David Greaves <david@dgreaves.com>, Kasper Sandberg <lkml@metanurb.dk>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, ml@magog.se, radsaq@gmail.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
Message-ID: <20060721091945.I1990742@wobbly.melbourne.sgi.com>
References: <20060720161121.GA26748@tuatara.stupidest.org> <20060721081452.B1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201817450.23697@p34.internal.lan> <20060721082448.C1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201843020.2619@p34.internal.lan> <20060721085230.F1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201855270.2652@p34.internal.lan> <20060721090015.G1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201910010.20652@p34.internal.lan> <20060720231245.GA32195@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060720231245.GA32195@tuatara.stupidest.org>; from cw@f00f.org on Thu, Jul 20, 2006 at 04:12:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 04:12:46PM -0700, Chris Wedgwood wrote:
> On Thu, Jul 20, 2006 at 07:10:46PM -0400, Justin Piszcz wrote:
> 
> > I can run this over and over, and the result is the same?
> 
> lost+found is recreated every time, rename it and you'll get less
> output

Yes this is the current xfs_repair behaviour (any previously
unlinked inodes will be found as unlinked on each successive
run, due to lost+found being recreated).  This will likely
be rethought soon (not far off), since it confuses everyone.

So, its all good - xfs_repair has fixed things and you're all
set now.

cheers.

-- 
Nathan
