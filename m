Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbUCJXiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUCJXiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:38:21 -0500
Received: from fmr05.intel.com ([134.134.136.6]:18359 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262558AbUCJXiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:38:20 -0500
Message-ID: <404FA6AC.7040009@linux.co.intel.com>
Date: Wed, 10 Mar 2004 17:37:16 -0600
From: James Ketrenos <jketreno@linux.co.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: jt@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com> <404F5744.1040201@pobox.com>
In-Reply-To: <404F5744.1040201@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

 > Yes, it would be good to end the cycle of re-implementing 802.11 over
 > and over again ;-)

< snip >

 > * start working on generic 802.11 stack in wireless-2.6 queue

As we're currently walking the path of implementing the same thing for the 
IPW2100 driver,  being able to re-use this code would be _very nice_.

I'd like to get WEP into IPW2100 as soon as possible, and would like to do so in 
a way that would make transitioning to a common 802.11 layer seamless (or at 
least reasonably isolated).  Any suggestions on how to best do this, or where we 
might be able to help, would be much appreciated.

I'm very interested in these discussions, so if they move to or are being 
discussed on another list (besides netdev), please let me know where.

Thanks,
James
