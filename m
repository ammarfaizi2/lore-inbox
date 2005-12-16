Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVLPMcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVLPMcU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVLPMcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:32:19 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:2044 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932220AbVLPMcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:32:19 -0500
Subject: Re: 2.6.15-rc5-rt2 slowness
From: Steven Rostedt <rostedt@goodmis.org>
To: G.Ohrner@post.rwth-aachen.de
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <dnu8ku$ie4$1@sea.gmane.org>
References: <dnu8ku$ie4$1@sea.gmane.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 07:32:05 -0500
Message-Id: <1134736325.13138.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 12:30 +0100, Gunter Ohrner wrote:
> Hi!
> 
> Thanks to Steven's Kconfig fixes I was able to compile 2.6.15-rc5 with
> Ingo's rt2-patch just fine.
> 
> I have two small problem with it, however. One is the Oops just posted, the
> other is a high system load and bad responsiveness of the system as a
> whole. I didn't even bother to measure timer/sleep jitters as the system
> was dog slow and the fans started to run a full speed nearly immediately.
> 
> We observed this on two different systems, one with the config attached to
> my mail with the Oops/backtrace.
> 
> I'll try to recompile the kernel with some debug options, if anyone knows if
> there's something I should specifically look for this may be helpful.

I'll look into your oops later (or maybe Ingo has some time), but I've
also notice the slowness of 2.6.15-rc5-rt2, and I'm investigating it
now.

Thanks,

-- Steve

