Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWIVMHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWIVMHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWIVMHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:07:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:696 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932340AbWIVMHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:07:17 -0400
Date: Fri, 22 Sep 2006 13:58:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: "K.R. Foley" <kr@cybsft.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060922115854.GA12684@elte.hu>
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com> <20060920194958.GA24691@elte.hu> <4511A57D.9070500@cybsft.com> <1158784863.5724.1027.camel@localhost.localdomain> <4511A98A.4080908@cybsft.com> <1158866166.12028.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158866166.12028.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4902]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> I'm seeing a similar issue. Although the log is a bit futzed. Maybe 
> its the sd_mod?
> 
>  at virtual address 75010000le kernel paging requestproc filesystem

would be nice to figure out why it crashes - unfortunately i cannot 
trigger it. Could it be some build tool incompatibility perhaps? Some 
sizing issue (some module struct gets too large)?

	Ingo
