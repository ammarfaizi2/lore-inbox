Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUEDODC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUEDODC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUEDOBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:01:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6379 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264373AbUEDOAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:00:31 -0400
Date: Mon, 3 May 2004 15:58:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paul Jakma <paul@clubi.ie>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 and diskless swap (nbd? nfs?)
Message-ID: <20040503135856.GF1188@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0405030037490.22749@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405030037490.22749@fogarty.jakma.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just curious, what is one supposed to do for swap for diskless 
> machines? Swap on NFS files refuses to work. Is swap on NBD possible 
> (googling suggests patches were required - did these make it in to 
> the kernel?). If not, is there any way at all to sanely do swap for 
> diskless machines with 2.6?

There's no way to make swapping over network work.

nbd patches never worked 100% reliably.

You'd have to write "nbd over netpoll".
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

