Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUASAa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 19:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbUASAa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 19:30:29 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:55680 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264308AbUASAa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 19:30:28 -0500
Date: Sun, 18 Jan 2004 16:30:19 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Randy Appleton <rappleto@nmu.edu>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Unneeded Code Found??
Message-ID: <20040119003019.GF1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Randy Appleton <rappleto@nmu.edu>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <3FFF3931.4030202@nmu.edu> <4006B998.5040403@tmr.com> <400B2BCF.7090003@nmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400B2BCF.7090003@nmu.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 07:58:55PM -0500, Randy Appleton wrote:
> Bill Davidsen wrote:
> >If you never get a hit, it means either (a) your test load actually 
> >doesn't have one, or (b) the code isn't correctly finding them.
> 
> 
> It might be buggy code on my part, but it looks pretty solid to me.   
> I'd be happy to show anyone interested.
> My load ought to find such a merge, if they happen with any freqency at 
> all.  Compiling two kernels
> at the same time and "general running" are my two current loads.  The 
> disk queue gets to over 70
> entries, which is rather high for a personal workstation, and I'm 
> searching tens of thousands to accesses
> in total.
> 
> Does anyone know that this code is actualy useful?  Has anyone ever seen 
> it actually do a merge of consecutive
> data accesses for requests that were not issued themselves consequtively?


What kernel version are you testing against?
