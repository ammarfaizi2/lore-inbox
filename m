Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUGSHwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUGSHwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUGSHwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 03:52:37 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:3471 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264782AbUGSHwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 03:52:36 -0400
Date: Mon, 19 Jul 2004 09:52:35 +0200
From: bert hubert <ahu@ds9a.nl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040719075235.GA10070@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Klaus Dittrich <kladit@t-online.de>,
	linux mailing-list <linux-kernel@vger.kernel.org>
References: <20040718215201.GA840@xeon2.local.here> <40FB7CC9.4060302@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FB7CC9.4060302@yahoo.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 05:48:25PM +1000, Nick Piggin wrote:
> Klaus Dittrich wrote:
> >rsync-2.6.2 of a large disc using 2.6.8-rc2 (I also tried 2.6.7-bk14)
> >stops with "kernel: Out of Memory: Killed process xxxx" messages
> >during filelist gathering.
> >
> >When this happens only 1.4 GB out of 2 GB RAM and no swap is used.
> >
> >No problems with kernel 2.6.7.
> >(Peak RAM usage during filelist gathering was 1.8 GB, no swap)
> >
> 
> Hi Klaus,
> What arguments are you running rsync with? Also, how many files, and
> how large are they?

And can you show the output of 'vmstat 1' during rsync? This is the second
report of linux 2.6.8-rc? eating all memory, btw.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
