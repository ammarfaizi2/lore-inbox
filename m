Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUHJM5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUHJM5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUHJMzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:55:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51854 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265051AbUHJMyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:54:31 -0400
Date: Tue, 10 Aug 2004 14:55:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>, V13 <v13@priest.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810125529.GA22650@elte.hu>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com> <20040810125140.GU11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810125140.GU11200@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> On Tue, Aug 10, 2004 at 03:52:20PM +0300, V13 wrote:
> > Why don't you create a copy of printk() and start commenting out lines in 
> > there?
> 
> This is a very good idea.

i'd guess it's the con->write() in __call_console_drivers() that makes
the difference. (i.e. touching the framebuffer)

	Ingo
