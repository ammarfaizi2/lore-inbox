Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVAMIOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVAMIOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVAMIOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:14:01 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:60084 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261203AbVAMINp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:13:45 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Thu, 13 Jan 2005 08:13:42 +0000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200501081613.27460.mmazur@kernel.pl> <200501121049.10219.andrew@walrond.org> <200501121211.23475.mmazur@kernel.pl>
In-Reply-To: <200501121211.23475.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501130813.42545.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 11:11, Mariusz Mazur wrote:
>
> Looks like you've linked your kernel's config.h to llh and that causes the
> problem. You shouldn't do that unless you have a specific reason to,
> otherwise you might end up with problems I'm unable to test for (I can't
> check every possible combination of kernel CONFIG_'s).
>

I know you are deliberately vague in the faq ;) But what about something like 
X11? It needs the real config.h in order to build the kernel DRM drivers. 
Should it be built against
 1) llh + blank config.h
 2) llh + real config.h
 3) kernel source

I guess this ambiguity would go away once the real kernel headers have been 
sanitized for userspace (ie we could always use the real config.h without 
fear of breakage) But as you have already stated, the issues are complex, and 
consensus is lacking. The longer the status quo continues, the more apps are 
going to break when we do get round to it.

And I think, in this instance, the "shut up and hack" response is 
inappropriate; Either these changes come from a senior linux hacker, or they 
will be ignored/derided (again).

Andrew Walrond

