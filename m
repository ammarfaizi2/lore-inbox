Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbUANHH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 02:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUANHH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 02:07:56 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:55190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264285AbUANHHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 02:07:55 -0500
Subject: Re: [2/3]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16388.28153.476037.234076@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
	 <20040113113650.A2975@flint.arm.linux.org.uk>
	 <20040113114948.B2975@flint.arm.linux.org.uk>
	 <20040113171544.B7256@flint.arm.linux.org.uk>
	 <20040113173352.D7256@flint.arm.linux.org.uk>
	 <16388.28153.476037.234076@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1074063680.760.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jan 2004 18:01:21 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 09:15, Paul Mackerras wrote:
> Russell King writes:
> 
> > Here are patches to drivers in the 2.6 kernel which have not been tested
> > to correct the tiocmset/tiocmget problem.
> 
> Note that drivers/macintosh/macserial.c is now deprecated, people
> should use drivers/serial/pmac_zilog.c.
> 
> Ben, is it time to get rid of macserial.c yet?

In 2.6 ? well, probably yes, I didn't find any problem with it so
far... On another hand, it wasn't much tested yet.

I still have a big bunch of driver updates I have to send to Andrew,
I'll eventually kill macserial at this point

Ben.


