Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFLT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFLT3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFLT3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:29:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7395 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262670AbVFLSlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 14:41:32 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Bill Huey <bhuey@lnxw.com>,
       Karim Yaghmour <karim@opersys.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
In-Reply-To: <20050612170147.GE5796@g5.random>
References: <20050610173728.GA6564@g5.random>
	 <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com>
	 <20050610223724.GA20853@nietzsche.lynx.com>
	 <20050610225231.GF6564@g5.random>
	 <20050610230836.GD21618@nietzsche.lynx.com>
	 <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com>
	 <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com>
	 <20050612170147.GE5796@g5.random>
Content-Type: text/plain
Date: Sun, 12 Jun 2005 14:43:02 -0400
Message-Id: <1118601783.20671.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 19:01 +0200, Andrea Arcangeli wrote:
> I seriously hoped core things
> like memory controller in the northbridge or embedded in the cpu would
> not risk to generate any starvation. 

Nforce4 chipsets have some problems that look like DMA starvation too,
the RME people claim to have traced it to the SATA controller.

http://www.rme-audio.de/english/techinfo/nforce4_tests.htm

Basically these all fall under common sense engineering, you don't use
buggy/unproved hardware for an RT or any mission critical system.  

Lee  

