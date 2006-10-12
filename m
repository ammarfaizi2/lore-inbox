Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422783AbWJLH31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWJLH31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWJLH31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:29:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422783AbWJLH3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:29:25 -0400
Date: Thu, 12 Oct 2006 00:29:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] lockdep: annotate i386 apm
Message-Id: <20061012002906.dd29c376.akpm@osdl.org>
In-Reply-To: <1160635850.2006.98.camel@taijtu>
References: <1160574022.2006.82.camel@taijtu>
	<20061011141813.79fb278f.akpm@osdl.org>
	<1160633180.2006.94.camel@taijtu>
	<20061011233925.c9ba117a.akpm@osdl.org>
	<1160635850.2006.98.camel@taijtu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 08:50:50 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Was my original _that_ hard to read?

The macro was bad enough.  Then you want an added another one and made it
reference a caller's local variable.  Another dummy-shaped dent in my wall.

I'd appreciate a fixed-up patch which changes the code's niceness in a
positive direction please - I'm obviously not cut out to work on apm.c.
