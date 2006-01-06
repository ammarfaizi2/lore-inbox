Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWAFT0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWAFT0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWAFT0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:26:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15834 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932498AbWAFT0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:26:42 -0500
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
In-Reply-To: <200601061358.42344.ak@suse.de>
References: <20060105235845.967478000@sorel.sous-sol.org>
	 <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
	 <43BE43B6.3010105@cosmosbay.com>  <200601061358.42344.ak@suse.de>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 14:26:39 -0500
Message-Id: <1136575600.17979.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 13:58 +0100, Andi Kleen wrote:
> Another CPU might be stuck in a long 
> running interrupt

Shouldn't a long running interrupt be considered a bug?

Lee

