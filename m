Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUDGWnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUDGWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:43:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34044 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261205AbUDGWnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:43:03 -0400
Date: Wed, 07 Apr 2004 15:54:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>
cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <10680000.1081378467@flay>
In-Reply-To: <20040406175722.GE2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406172431.GA9185@elte.hu> <20040406175722.GE2234@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> is on you. And if you think i'm upset about your approach to this whole
>> issue then you are damn right.)
> 
> the one upset should be the users running 30% slower with stuff like
> mysql just because they own a 4/8G box. There's little interest from my
> part to spend time on 4:4 stuff when things are so obvious (I want
> however to try to benchmark the HZ=1000 with the hint).

Isn't that scenario fixed up by vsyscall gettimeofday already? 
Or was this another workload, where gettimeofday wasn't the problem?

M.

