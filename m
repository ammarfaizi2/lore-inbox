Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTHaFWB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 01:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTHaFWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 01:22:01 -0400
Received: from newmx2.fast.net ([209.92.1.32]:960 "HELO newmx2.fast.net")
	by vger.kernel.org with SMTP id S262507AbTHaFV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 01:21:27 -0400
Subject: Re: PROBLEM: keyboard shift not registered under fast typing or
	auto-repeat
From: Carl Nygard <cjnygard@fast.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030830221548.A3654@pclin040.win.tue.nl>
References: <1061944729.14320.74.camel@finland>
	 <20030827125056.A1854@pclin040.win.tue.nl>
	 <1062201326.14320.117.camel@finland>
	 <20030830221548.A3654@pclin040.win.tue.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1062306217.23441.1.camel@finland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 31 Aug 2003 01:03:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-30 at 16:15, Andries Brouwer wrote:
> On Fri, Aug 29, 2003 at 07:56:22PM -0400, Carl Nygard wrote:
> 
> > > > Kernel doesn't register shift state when typing quickly.
> > > > Example, 'ls *' shows up as 'ls 8' when typed fast.
> > 
> > Typing quickly: 
> > 
> >      ## ^--- Shift-up event
> > (and the Shift-down event was never seen)
> >
> > typing slower,
> > 
> >     ## ^---- Shift-down event
> >     ## ^---- Shift-up event
> >
> > Is this potentially a hardware problem
> > (i.e. should I return my laptop, because this is too d*mn annoying)?
> 
> You can try to decide by running a 2.4 kernel on this laptop.
> If also 2.4 fails it may be hardware. If not, we must fix 2.6.

It was the same behavior on 2.4.20, 2.4.21, 2.6.0-test3/4, and also XP. 
It's a hardware problem, I'm sending the thing in for repair.

Sorry for the false alarm, but it helped to narrow down what was
happening, so thanks for the pointers.

-- 
Carl Nygard <cjnygard@fast.net>

