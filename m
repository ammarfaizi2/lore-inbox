Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVHLNHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVHLNHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVHLNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:07:32 -0400
Received: from mail.suse.de ([195.135.220.2]:35714 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751168AbVHLNHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:07:31 -0400
Date: Fri, 12 Aug 2005 15:07:26 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Mike Waychison <mikew@google.com>,
       YhLu <YhLu@tyan.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org, "discuss@x86-64.org" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Message-ID: <20050812130725.GL8974@wotan.suse.de>
References: <42FA8A4B.4090408@google.com> <20050810232614.GC27628@wotan.suse.de> <86802c4405081016421db9baa5@mail.gmail.com> <20050811000430.GD8974@wotan.suse.de> <86802c4405081017174c22dcd5@mail.gmail.com> <86802c440508101723d4aadef@mail.gmail.com> <20050811002841.GE8974@wotan.suse.de> <86802c440508101743783588df@mail.gmail.com> <20050811005100.GF8974@wotan.suse.de> <86802c4405081123597239dff7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c4405081123597239dff7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 11:59:21PM -0700, yhlu wrote:
> andi,
> 
> is it possible for
> after the AP1 call_in is done and before AP1 get in tsc_sync_wait
> The AP2 call_in done.  and then AP1 get in tsc_sync_wait and before it
> done, AP2 get in tsc_sync_wait too.
> 
> sync_master can not figure out from AP1 or AP2 because only have
> go[MASTER] and go{SLAVE].

Ok, you're right. It's better to move it to before callin map.

-Andi
