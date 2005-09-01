Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVIAU1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVIAU1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVIAU1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:27:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47782 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030372AbVIAU1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:27:48 -0400
Date: Thu, 1 Sep 2005 22:28:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rt3
Message-ID: <20050901202830.GB27229@elte.hu>
References: <1125591893.7842.7.camel@localhost.localdomain> <1125593160.5761.3.camel@localhost.localdomain> <1125603507.5810.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125603507.5810.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> I just found a __MAJOR__ bug in my code.  Below is the patch that 
> fixes this bug, zaps the WARN_ON in check_pi_list_present, and changes 
> ALL_TASKS_PI to a booleon instead of just a define.
> 
> The major bug was in __down_trylock.  See anything wrong with this 
> code :-) I'm surprised that this worked as well as it did!

ok, i've released -rt4 with this fix included. The 8-way box boots fine 
now.

	Ingo
