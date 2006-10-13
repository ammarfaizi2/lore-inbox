Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWJMGVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWJMGVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWJMGVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:21:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4754 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750783AbWJMGVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:21:12 -0400
Date: Fri, 13 Oct 2006 08:13:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, khali@linux-fr.org,
       i2c@lm-sensors.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: lockdep warning in i2c_transfer() with dibx000 DVB - input tree merge plans?
Message-ID: <20061013061328.GA15191@elte.hu>
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Kosina <jikos@jikos.cz> wrote:

> However the patch introducing lockdep_set_subclass() is currently only 
> in Dmitry's input tree (commit 
> 4dfbb9d8c6cbfc32faa5c71145bd2a43e1f8237c) - but the fix for DVB/I2C 
> hardly belongs to input tree, so I am quite stuck.

It looks good to me - i'd suggest to get that commit upstream, either 
directly or via the input tree.

	Ingo
