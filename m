Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWGQF33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWGQF33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 01:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWGQF32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 01:29:28 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:39903 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932106AbWGQF32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 01:29:28 -0400
Date: Mon, 17 Jul 2006 01:21:57 -0400
From: Ralf Baechle <ralf@linux-mips.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Albert Cahalan <acahalan@gmail.com>, dwmw2@infradead.org,
       maillist@jg555.com, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060717052157.GA3674@linux-mips.org>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com> <1152998347.3114.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152998347.3114.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 11:19:06PM +0200, Arjan van de Ven wrote:

> > The attraction is that the kernel abstractions are very nice.
> > Much of the POSIX API sucks ass. The kernel stuff is NOT crap.
> > 
> > Here we have a full-featured set of atomic ops,
> 
> which are not atomic actually in userspace (hint: most apps don't have
> CONFIG_SMP set)

Atomic ops for some architectures / configuration won't even work at al
in userspace because they're implemented by disabling interrupts.

  Ralf
