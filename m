Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWFTGnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWFTGnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWFTGnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:43:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59334 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965097AbWFTGnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:43:52 -0400
Date: Tue, 20 Jun 2006 16:43:38 +1000
From: Nathan Scott <nathans@sgi.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Message-ID: <20060620164338.A1080488@wobbly.melbourne.sgi.com>
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> <20060620161006.C1079661@wobbly.melbourne.sgi.com> <3aa654a40606192338v751150fp5645d1d2943316ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3aa654a40606192338v751150fp5645d1d2943316ea@mail.gmail.com>; from avuton@gmail.com on Mon, Jun 19, 2006 at 11:38:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:38:58PM -0700, Avuton Olrich wrote:
> On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> > If so, can you try Mandy's patch below, to see if it is addressing
> > the root cause of your problem?  If problems persist, a reproducible
> > test case would be wonderful, if one can be found..
> 
> I'm sorry, the patch doesn't change anything. It never makes it though
> the xfs_repair due to the above error. If there's any information I
> can get for you please let me know.

Oh - thats a kernel patch, not a repair patch, I was more interested
in whether the initial corruption could be reproduced.  Which version
of xfs_repair are you running?  (xfs_repair -V)  xfsprogs-2.7.18 will
resolve your problem, I suspect.

cheers.

-- 
Nathan
