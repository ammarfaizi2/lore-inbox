Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274884AbTHFHGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274885AbTHFHGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:06:39 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:6917
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S274884AbTHFHGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:06:38 -0400
Date: Wed, 6 Aug 2003 00:06:25 -0700
To: OSDL <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806070625.GA5602@nasledov.com>
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308060559.h765xhI05860@mail.osdl.org>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 05, 2003 at 10:59:43PM -0700, OSDL wrote:
> You should try with just CONFIG_YENTA - the 82365 stuff is for the old
> 16-bit only controllers.

While playing around with 2.6.0-test2 on my laptop, I tried to see if
APM support still worked on it. When I tried apm --suspend, the screen
would blank, but it would unblank as soon as I hit a key and I would
have the syslog messages "kernel: Suspending devices" and "kernel:
Devices Resumed." I found that if I ejected my card and made sure the
drivers were properly unloaded, apm --suspend once again suspended my
laptop. Under 2.4, the kernel would properly suspend while cards were
loaded, although I would sometimes have issues with waking the laptop
up if the state it was woken up in did not match the state it was put
to sleep in.
-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
