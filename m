Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUDAX0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 18:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUDAX0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 18:26:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15246
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262741AbUDAX0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 18:26:06 -0500
Date: Fri, 2 Apr 2004 01:26:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401232603.GE18585@dualathlon.random>
References: <20040401223619.GB18585@dualathlon.random> <Pine.LNX.4.44.0404011807350.5589-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404011807350.5589-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 06:08:18PM -0500, Rik van Riel wrote:
> Oracle seems to be using it just fine in a certain 2.4
> based kernel, so why exactly do you think it would be
> useless for the problem you want to solve ?
> 
> Also, what would need to be fixed in order for it to
> not be useless ? ;)

tell me how to call shmget(SHM_HUGETLB) without having the CAP_IPC_LOCK
with the rlimit patch.
