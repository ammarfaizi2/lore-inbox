Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVCCUij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVCCUij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVCCUeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:34:25 -0500
Received: from krusty.vfxcomputing.com ([66.92.20.10]:33515 "EHLO
	krusty.vfxcomputing.com") by vger.kernel.org with ESMTP
	id S262565AbVCCUdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:33:22 -0500
Date: Thu, 3 Mar 2005 15:33:03 -0500 (EST)
From: Mark Canter <marcus@vfxcomputing.com>
To: Lee Revell <rlrevell@joe-job.com>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
In-Reply-To: <1109876978.2908.31.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>  <29495f1d05030309455a990c5b@mail.gmail.com>
  <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com> 
 <1109875926.2908.26.camel@mindpipe>  <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
 <1109876978.2908.31.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To close this issue out of the LKML and alsa-devel, a bug report has been 
written.

It appears to be an issue with the 'headphone jack sense' (as kde labels 
it).  The issue is in the way the 8x0 addresses the docking station/port 
replicator's audio output jack.  The mentioned quick fix does not work for 
using the ds/pr audio output, but does resolve it for a user that is only 
using headphones/internal speakers.

mark
