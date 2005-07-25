Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVGYVZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVGYVZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVGYVZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:25:54 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61830 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261490AbVGYVZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:25:52 -0400
Subject: RE: Variable ticks
From: Lee Revell <rlrevell@joe-job.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AC59@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 17:25:49 -0400
Message-Id: <1122326750.1472.46.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 17:19 -0400, Brown, Len wrote:
>  >>>Question one, are there other actions to consider?
> >> 
> >> 
> >> Yes.
> >> Speaking for ACPI C3 state, note that DMA also
> >> wakes up the CPU -- even if there was no device interrupt.
> >> (aka, "the trouble with USB")
> >
> >Trouble? Why would USB do DMA unless there was a device activity?
> 
> look here:
> http://www.google.com/search?hl=en&q=usb+selective+suspend
> 
> Linux is working on it too, but it is in development.

What about audio?  If there is a sound server running then you're going
to have a constant stream of interrupts and DMA activity from the sound
card even if the machine is idle and there aren't any sounds playing.

Lee

