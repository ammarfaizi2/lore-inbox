Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWHKEQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWHKEQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 00:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHKEQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 00:16:21 -0400
Received: from 1wt.eu ([62.212.114.60]:50957 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751175AbWHKEQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 00:16:20 -0400
Date: Fri, 11 Aug 2006 05:57:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: Neil Brown <neilb@suse.de>
Cc: Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
Message-ID: <20060811035756.GB1261@1wt.eu>
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com> <20060810045711.GI8776@1wt.eu> <17627.53340.43470.60811@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17627.53340.43470.60811@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 10:33:32AM +1000, Neil Brown wrote:
> On Thursday August 10, w@1wt.eu wrote:
> > 
> > > Can someone help me and give me a brief description on OOM issue?
> > 
> > I don't know about any OOM issue related to NFS. At most it might happen
> > on the client (eg: stating firefox from an NFS root) which might not have
> > enough memory for new network buffers, but I don't even know if it's
> > possible at all.
> 
> We've had reports of OOM problems with NFS at SuSE.
> The common factors seem to be lots of memory (6G+) and very large
> files. 

Just out of curiosity, does it happen on 32bit or 64bit machines (or both) ?

> Tuning down  /proc/sys/vm/dirty_*ratio seems to avoid the problem,
> but I'm not very close to understanding what the real problem is.

The most important is to be aware of it ;-)

> NeilBrown

Thanks for the info,
Willy

