Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSJVDPD>; Mon, 21 Oct 2002 23:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSJVDPC>; Mon, 21 Oct 2002 23:15:02 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:54278
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262045AbSJVDPB>; Mon, 21 Oct 2002 23:15:01 -0400
Subject: Re: Son of crunch time: the list v1.2.
From: Robert Love <rml@tech9.net>
To: landley@trommello.org
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200210211642.10435.landley@trommello.org>
References: <20021021135137.2801edd2.rusty@rustcorp.com.au>
	<200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com> 
	<200210211642.10435.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 23:20:49 -0400
Message-Id: <1035256849.1044.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 17:42, Rob Landley wrote:

> On Monday 21 October 2002 21:02, Jeff Garzik wrote:
> > Rob Landley wrote:
>
> > > 9) High resolution timers (George Anzinger, etc.)
> > > http://high-res-timers.sourceforge.net/
> >
> > no comment, I've heard arguments that high-res timers would be useful,
> > but haven't read the patch myself so won't comment...
> 
> I vaguely remember Linus had some objections that it plays with the clock tick 
> and potentially penalizes everybody...  Hmmm...
> 
> A quick google comes up with this:
> 
> http://www.cs.helsinki.fi/linux/linux-kernel/2002-28/0360.html

George said he would change the code to meet Linus's issues (re the sub
jiffies stuff).  But there was not much debate either way, and I suspect
George may in fact be correct.

George also offered an interface-only version of the patch that
implements the POSIX clocks and timers syscalls, without the high
resolution support, so it would be nice to at the very least merge the
missing POSIX functionality.

	Robert Love

