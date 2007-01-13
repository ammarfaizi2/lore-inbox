Return-Path: <linux-kernel-owner+w=401wt.eu-S1422691AbXAMPeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbXAMPeT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 10:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbXAMPeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 10:34:19 -0500
Received: from styx.suse.cz ([82.119.242.94]:39520 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422691AbXAMPeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 10:34:18 -0500
Date: Sat, 13 Jan 2007 16:34:13 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [PATCH] Fix some ARM builds due to HID brokenness
In-Reply-To: <20070112215351.GD24451@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0701131631490.5228@jikos.suse.cz>
References: <20070112210015.GA2923@dyn-67.arm.linux.org.uk>
 <20070112214216.GC24451@flint.arm.linux.org.uk> <20070112215351.GD24451@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007, Russell King wrote:

> > So... we have USB_HID _newly_ selected in configurations which didn't 
> > have it before, which overrides CONFIG_HID and builds HID without 
> > input support. Can USB_HID also depend on INPUT ?
> Nevertheless, here's a patch to solve more of the same that my original
> patch attempted to solve.  The original patch is still required.  Seems
> to solve the final instance of this problem here.

Yes, it is by the time being needed for USB_HID to depend on input. Thanks 
for the patch, I applied it to HID tree and will push it upstream in the 
next round.

-- 
Jiri Kosina
SUSE Labs
