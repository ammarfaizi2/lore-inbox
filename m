Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbSJDTWp>; Fri, 4 Oct 2002 15:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbSJDTWp>; Fri, 4 Oct 2002 15:22:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:48394
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261834AbSJDTWo>; Fri, 4 Oct 2002 15:22:44 -0400
Subject: Re: O(1) Scheduler from Ingo vs. O(1) Scheduler from Robert
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210041726350.3806-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210041726350.3806-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 15:28:37 -0400
Message-Id: <1033759718.1247.96.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 11:28, Ingo Molnar wrote:

> On 4 Oct 2002, Robert Love wrote:
> 
> > There should _not_ be other things in the patch aside from the
> > scheduler. [...]
> 
> hm, i remember there was some 'set max RT priority in .config' stuff
> in it, isnt that the case anymore?

Oh, yes, indeed.  I forgot about that.

Since we cleaned up the whole MAX_PRIO thing the only main difference in
my tree is that fact it is exported as a CONFIG setting (and the logic
to implement a new ffs if BITMAP_SIZE changes).

Otherwise the trees aim to be in-sync.

	Robert Love

