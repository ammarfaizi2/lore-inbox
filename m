Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUG3Rif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUG3Rif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUG3Rif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:38:35 -0400
Received: from mail.aei.ca ([206.123.6.14]:44774 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267754AbUG3Rib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:38:31 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040730152040.GA13030@elte.hu>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
Content-Type: text/plain
Message-Id: <1091209106.2356.3.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 13:38:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-07-30 at 11:20, Ingo Molnar wrote:
> * Shane Shrybman <shrybman@aei.ca> wrote:
> 
> > Twice while using -L2 my IBM PS2 keyboard has become completely
> > non-responsive. USB mouse and everything else seems to be fine, but no
> > LEDs or anything from the keyboard.
> > 
> > On both occasions the last key I hit on the keyboard was numlock and the
> > numlock did not come on and I had to reboot after that.
> > 
> > UP, x86, gcc 2.95, scsi + ide, bttv
> > 
> > Resolved in M5?
> 
> M5 does that differently, yes - so could you try it? If you still get
> problems, does this fix it:
> 

Ok, M5 locked up the whole machine within a few seconds of starting X.

> 	echo 0 > /proc/irq/1/*/threaded
> 

I rebooted and tried the above command, but the keyboard became
unresponsive again soon after starting X.

> (this turns the IRQ 1 thread off.)
> 
> 	Ingo
> 

Shane

