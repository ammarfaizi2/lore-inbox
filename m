Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbTCQGSC>; Mon, 17 Mar 2003 01:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262904AbTCQGSC>; Mon, 17 Mar 2003 01:18:02 -0500
Received: from holomorphy.com ([66.224.33.161]:54744 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262903AbTCQGSB>;
	Mon, 17 Mar 2003 01:18:01 -0500
Date: Sun, 16 Mar 2003 22:28:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Mark Haverkamp <markh@osdl.org>
Subject: Re: [Lse-tech] [PATCH][ANNOUNCE] 32way/8quad NUMAQ booting with 16 IOAPICs, 223 IRQs
Message-ID: <20030317062838.GN5891@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>,
	Mark Haverkamp <markh@osdl.org>
References: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com> <20030317055415.GM5891@holomorphy.com> <Pine.LNX.4.50.0303170107560.2229-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303170107560.2229-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003, William Lee Irwin III wrote:
>> Running out of IRQ's? Simply jacking up NR_IRQS and HARDIRQ_BITS should
>> suffice if this is what I think it is.

On Mon, Mar 17, 2003 at 01:11:44AM -0500, Zwane Mwaikambo wrote:
> I'll have to see what repurcussions that will bring about, but i'll add 
> that to the TODO list.

Well, I tried it in my prior attempt and didn't have problems in that
area. AFAICT it "just works" if you jack up the numbers.

Also, NUMA-Q's max at 640 routeable RTE's with 16 quads so you'll only
need to add 1 to HARDIRQ_BITS.

The cpu count issue I've fixed in a separate patch.


-- wli
