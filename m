Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266900AbUHITac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266900AbUHITac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUHITaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:30:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:43649 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266900AbUHITSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:18:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc3-mm2
Date: Mon, 9 Aug 2004 12:17:50 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com>
In-Reply-To: <200408091132.39752.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091217.50786.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 9, 2004 11:32 am, Jesse Barnes wrote:
> > I'd be suspecting one of the CPU scheduler patches.
>
> Yep, that's what I'm looking at now...

If I apply everything up to and including schedstat-v10.patch, it boots fine.  
So it might be sched-init_idle-fork_by_hand-consolidation.patch or something 
nearby...  Just reverting the sched-single-array.patch wasn't enough.

Jesse
