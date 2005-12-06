Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVLFIN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVLFIN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVLFIN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:13:28 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:46483 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1750745AbVLFIN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:13:27 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Greg KH <greg@kroah.com>, Tim Bird <tim.bird@am.sony.com>,
       Dave Airlie <airlied@gmail.com>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051206060734.GB7096@alpha.home.local>
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
	 <4394DA1D.3090007@am.sony.com> <20051206040820.GB26602@kroah.com>
	 <20051206060734.GB7096@alpha.home.local>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 08:13:10 +0000
Message-Id: <1133856790.4136.5.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 07:07 +0100, Willy Tarreau wrote:
> Most of those small companies who propose a Linux driver simply start
> by paying a student during summer for porting their
> windows/sco/whatever driver to linux. They think the job is done when
> he leaves. Unfortunately, they receive complaints 3 months later from
> users because the driver is broken and does not build. They don't have
> the resources to keep a permanent developer on it, and they quickly
> understand that Linux is just a "geek OS" and that it's the last time
> they release any driver.

If they hired someone who did a _proper_ job -- writing a fully portable
and maintainable driver which got merged into Linus' kernel, then this
scenario doesn't make much sense. In-kernel code does generally get
maintained as interfaces change.

Of course, maintaining a driver _outside_ the kernel tree is a
never-ending task -- but why would anybody ever want to do that?

-- 
dwmw2


