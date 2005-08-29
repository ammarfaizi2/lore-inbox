Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVH2LRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVH2LRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 07:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVH2LRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 07:17:55 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:11165 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750837AbVH2LRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 07:17:54 -0400
Date: Mon, 29 Aug 2005 13:18:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: 2.6.13-rt1
Message-ID: <20050829111832.GA10734@elte.hu>
References: <20050829084829.GA23176@elte.hu> <1125313744.5611.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125313744.5611.13.camel@localhost.localdomain>
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
> I think you have a slight glitch in your patch.
> 
> -- Steve
> 
> $ patch -p1 -s < /work/realtime-patches/patch-2.6.13-rt1
> The next patch would delete the file Makefile.rej,
> which does not exist!  Assume -R? [n]
> Apply anyway? [n]

indeed. I fixed this up in the file without uploading a new release, so 
new downloads shouldnt see this.

	Ingo
