Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVLTPHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVLTPHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVLTPHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:07:55 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58799 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751089AbVLTPHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:07:54 -0500
Date: Tue, 20 Dec 2005 16:07:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-rt2 slowness
Message-ID: <20051220150711.GA5505@elte.hu>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain> <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135089221.13138.269.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135089221.13138.269.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> As you see, the new SLOB code runs almost as fast as the SLAB code. 
> With some more improvements, I'm sure it can get even faster.

cool, the numbers are really impressive! I'm wondering where the biggest 
hit comes from - perhaps the SLOB does linear list walking when 
allocating?

	Ingo
