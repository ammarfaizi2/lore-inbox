Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVBIBgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVBIBgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVBIBge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:36:34 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:52997 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261735AbVBIBgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:36:21 -0500
Date: Wed, 9 Feb 2005 02:36:17 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: cliff white <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.10-ac12 + kernbench ==  oom-killer: (OSDL)
Message-ID: <20050209013617.GC2686@pclin040.win.tue.nl>
References: <20050208145707.1ebbd468@es175>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208145707.1ebbd468@es175>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 02:57:07PM -0800, cliff white wrote:

> Running 2.6.10-ac10 on the STP 1-CPU machines, we don't seem to be able to complete
> a kernbench run without hitting the OOM-killer. ( kernbench is multiple kernel compiles,
> of course ) Machine is 800 mhz PIII with 1GB memory. We reduce memory for some of the runs.
> 
> Typical results:
> 
> Out of Memory: Killed process 14970 (cc1).
> -------------------------
> It looks like some oom-related stuff went into -ac10, will try retest with 
> -ac9 and -ac10, see what happens. Lemme know if we can do more

I am always curious to hear how things are when you set
/proc/sys/vm/overcommit_memory to 2
(and possibly /proc/sys/vm/overcommit_ratio to something
appropriate).

Andries

