Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265527AbSJSGbo>; Sat, 19 Oct 2002 02:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSJSGbo>; Sat, 19 Oct 2002 02:31:44 -0400
Received: from holomorphy.com ([66.224.33.161]:16300 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265527AbSJSGbn>;
	Sat, 19 Oct 2002 02:31:43 -0400
Date: Fri, 18 Oct 2002 23:32:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Voyager subarchitecture for 2.5.44
Message-ID: <20021019063230.GE23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
References: <200210190612.g9J6Cqu11812@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210190612.g9J6Cqu11812@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 01:12:52AM -0500, James Bottomley wrote:
> This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
> SMP microchannel non-PC architecture.
> The current patch includes a swap around of the timer code defines (available 
> separately at http://linux-voyager.bkbits.net/timer-2.5) and a new 
> CONFIG_X86_TRAMPOLINE config option to avoid the trampoline vpath.
> The patch (156k) is available here:
> http://www.hansenpartnership.com/voyager/files/voyager-2.5.44.diff
> And also via bitkeeper at
> http://linux-voyager.bkbits.net/voyager-2.5

This is a very interesting architecture. Could you describe vaguely (for
someone starved enough for time he might have trouble finding time to
examine your tree) how cpu wakeup with the VIC proceeds?

Also, I'd like to say this patch is impressively isolated from generic
i386 code. Although I've not tested, it seems very clear from the form
of the code that it will have no impact on UP i386 or other subarches.


Thanks,
Bill
