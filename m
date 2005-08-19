Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVHSHM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVHSHM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVHSHM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:12:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964892AbVHSHM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:12:28 -0400
Date: Fri, 19 Aug 2005 00:10:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@davemloft.net, riel@redhat.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
Message-Id: <20050819001030.52ec1364.akpm@osdl.org>
In-Reply-To: <1124435027.23757.0.camel@localhost.localdomain>
References: <20050817173818.098462b5.akpm@osdl.org>
	<20050817.194822.92757361.davem@davemloft.net>
	<20050817210532.54ace193.akpm@osdl.org>
	<20050817.214845.120320066.davem@davemloft.net>
	<1124435027.23757.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> On Wed, 2005-08-17 at 21:48 -0700, David S. Miller wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > Date: Wed, 17 Aug 2005 21:05:32 -0700
> > 
> > > Perhaps by uprevving the compiler version?
> > 
> > Can't be, we definitely support gcc-2.95 and that compiler
> > definitely has the bug on sparc64.
> 
> I believe we just ignored sparc64.  That usually works for solving these
> kind of bugs. 8)

heh.  iirc, it was demonstrable on x86 also.

Dunno, it beats me.  But it is the case that we now have lots of
uninitialised DEFINE_PER_CPUs and nobody's crashing.  hm..
