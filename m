Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTLDWlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTLDWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:41:10 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:14209
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263625AbTLDWlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:41:05 -0500
Date: Thu, 4 Dec 2003 17:39:56 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Jason Walker <jason_walker@bellsouth.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to address 1GB RAM in 2.4.19 or later
In-Reply-To: <20031204223032.GA8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312041737295.27578@montezuma.fsmlabs.com>
References: <20031204181014.QPLW12995.imf20aec.mail.bellsouth.net@debian>
 <Pine.LNX.4.58.0312041709290.27578@montezuma.fsmlabs.com>
 <20031204223032.GA8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, William Lee Irwin III wrote:

> On Thu, 4 Dec 2003, Jason Walker wrote:
> >> Both are SMP kernels. The hardware is a Compaq Proliant 5000R, quad pentium pro
> >> 200mhz (256k cache models).
> >> Any thoughts on this? Is there any other information needed to address this
> >> issue? Please let me know what I can do to assist in correcting this bug.
>
> On Thu, Dec 04, 2003 at 05:21:14PM -0500, Zwane Mwaikambo wrote:
> > You are using mem= what happens without it? I wonder if mem= is broken
> > again.
>
> Both of the BIOS-88 tables match; for some reason 2.4.18 ignored the
> fact it was only reporting 16MB. It should see an e820...

I think his box may be too old for an e820 and BIOS-88 only does 0-64Mb
or so.
