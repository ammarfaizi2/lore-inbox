Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269740AbRHRDSU>; Fri, 17 Aug 2001 23:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRHRDSK>; Fri, 17 Aug 2001 23:18:10 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:7950 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S269740AbRHRDR6>;
	Fri, 17 Aug 2001 23:17:58 -0400
Date: Fri, 17 Aug 2001 21:14:06 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: kfree safe in interrupt context?
Message-ID: <20010817211406.A21326@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Xrnn-0008Bl-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like calling kfree from interrupt context should
be ok, but is it? 
If it is safe, is this considered a good thing  or not?


