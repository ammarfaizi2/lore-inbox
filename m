Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274972AbRJJGq1>; Wed, 10 Oct 2001 02:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274989AbRJJGqT>; Wed, 10 Oct 2001 02:46:19 -0400
Received: from ns.suse.de ([213.95.15.193]:65038 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S274972AbRJJGqK>;
	Wed, 10 Oct 2001 02:46:10 -0400
Date: Wed, 10 Oct 2001 08:46:41 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Thomas Hood <jdthood@mail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sysctl interface to bootflags?
In-Reply-To: <1002596188.5283.17.camel@thanatos>
Message-ID: <Pine.LNX.4.30.0110100844340.26743-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Oct 2001, Thomas Hood wrote:

> Well, it may run, but what it changed was NOT the SBF field.
> When I restarted my machine the BIOS beeped and told me
> there was an error in the nonvolatile RAM.  I was made to
> reset the system date, and then the computer rebooted
> normally.

Ouch. Can you verify that the CMOS register its changing matches
with what's listed in the BOOT record ?
add a printk to bootflag.c to check.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

