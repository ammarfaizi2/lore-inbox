Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSLKAJw>; Tue, 10 Dec 2002 19:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbSLKAJV>; Tue, 10 Dec 2002 19:09:21 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:5600 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266853AbSLKAJA>;
	Tue, 10 Dec 2002 19:09:00 -0500
Date: Tue, 10 Dec 2002 16:10:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: =?ISO-8859-1?Q?=22R=FCegg=2C_Peter_H=2E=22?= 
	<peter.ruegg@eenterprises.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Complete freeze with 2.4.20 on 4-proc IBM xSeries 350
Message-ID: <11930000.1039565421@flay>
In-Reply-To: <E8EE16A19D69D611B40000D0B73EBB250F06BE@exchange.intern.eproduction.ch>
References: <E8EE16A19D69D611B40000D0B73EBB250F06BE@exchange.intern.eproduction.ch>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm experiencing serious problems with Kernel 2.4.20 on a IBM xSeries 350
> machine, having 4 700 MHz processors and 4 GB RAM (same on another machine
> with the same configuration, but only 3 GB RAM). The machine just com-
> pletely freezes after some time, ranging from 20 minutes to 3 hours. It
> is running IBM DB/2 with quite some load, the base system is RedHat 7.2
> with all the updates applied. There is no oops or other fault, just a
> plain freeze.

Can you watch /proc/meminfo and see how low "lowfree" gets?
If it gets low (eg below 50Mb), dump /proc/slabinfo as well.

M.

