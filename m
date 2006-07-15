Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWGOVTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWGOVTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 17:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWGOVTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 17:19:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6579 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161041AbWGOVTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 17:19:12 -0400
Subject: Re: 2.6.18 Headers - Long
From: Arjan van de Ven <arjan@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: dwmw2@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 23:19:06 +0200
Message-Id: <1152998347.3114.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 17:09 -0400, Albert Cahalan wrote:
> David Woodhouse writes:
> 
> > Kernel headers are _not_ a library of random crap for userspace to use.
> 
> The attraction is that the kernel abstractions are very nice.
> Much of the POSIX API sucks ass. The kernel stuff is NOT crap.
> 
> Here we have a full-featured set of atomic ops,

which are not atomic actually in userspace (hint: most apps don't have
CONFIG_SMP set)



