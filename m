Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWCNStz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWCNStz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWCNStz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:49:55 -0500
Received: from silver.veritas.com ([143.127.12.111]:64567 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751928AbWCNSty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:49:54 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,191,1139212800"; 
   d="scan'208"; a="35869608:sNHT21693244"
Date: Tue, 14 Mar 2006 18:50:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Clayton <andrew@rootshell.co.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
In-Reply-To: <1142353443.30466.2.camel@zeus.pccl.info>
Message-ID: <Pine.LNX.4.61.0603141843110.6114@goblin.wat.veritas.com>
References: <1142337319.4412.2.camel@zeus.pccl.info> 
 <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com> 
 <Pine.LNX.4.64.0603140805380.3618@g5.osdl.org> <1142353443.30466.2.camel@zeus.pccl.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Mar 2006 18:49:54.0577 (UTC) FILETIME=[155EC010:01C64798]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Andrew Clayton wrote:
> On Tue, 2006-03-14 at 08:06 -0800, Linus Torvalds wrote:
> > 
> > Reverted. Let's get wider testing before applying an alternate fix.
> 
> Just to note: Doing what Andi suggested seems to be working OK.

Whereas on EM64T I found the opposite,
reverting just the stub_execve hunk still behaved badly.

I've double-checked that finding since, built and ran another
kernel to confirm it.  But your Athlon64 still works OK that way?

Just trying to clarify - I don't think we're in any rush to
settle it now that Linus has reverted the damage from his tree.

Hugh
