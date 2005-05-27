Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVE0Qfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVE0Qfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVE0Qfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:35:46 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49929
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262490AbVE0Qfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:35:42 -0400
Date: Fri, 27 May 2005 18:35:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Duncan Sands <baldrick@free.fr>
Cc: Takashi Iwai <tiwai@suse.de>, Andi Kleen <ak@muc.de>,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527163538.GA5413@g5.random>
References: <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de> <1117204044.23459.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117204044.23459.43.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 04:27:24PM +0200, Duncan Sands wrote:
> Or change (almost) all calls to might_sleep() into calls to
> cond_reched(), and put a might_sleep() inside cond_reched().

indeed

http://www.ussg.iu.edu/hypermail/linux/kernel/0407.1/1422.html

Who on earth would ever compile a kernel with PREEMPT_VOLUNTARY=n?
That's just a marketing word and useless config option as far as I can
tell. Anyway it's just source code overhead, at runtime the code is the
same, so I don't care after all.
