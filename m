Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTFTBKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 21:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFTBKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 21:10:14 -0400
Received: from mail8.kc.rr.com ([24.94.162.176]:8968 "EHLO mail8.kc.rr.com")
	by vger.kernel.org with ESMTP id S262123AbTFTBKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 21:10:12 -0400
Date: Thu, 19 Jun 2003 20:24:11 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: memory problem with 2.4.21 SMP on Dell Dimension 8300 (i875p chipset)
Message-ID: <20030620012411.GA1532@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030616021059.GA1671@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616021059.GA1671@glitch.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still haven't figured this one out, but for whatever it's worth
2.5.72 doesn't appear to trigger the problem.  Guess I won't worry
about it too much. ;-)

On Sun, Jun 15, 2003 at 09:10:59PM -0500, Greg Norris wrote:
> After running a SMP 2.4.21 kernel on my Dell Dimension 8300, the BIOS
> thinks that the amount of memory has changed.  When the box is
> rebooted, I get the following message at the end of BIOS
> initialization:
> 
>    The amount of system memory has changed.
>    Alert! OS Install Mode enabled. Amount of available memory limited to 256MB.
> 
> At this point the bootup hangs, waiting for someone to press F1
> (resume) or F2 (setup).  Any idea what's triggering this behaviour, and
> what I can do to squash it?  This issue doesn't occur when using a UP
> kernel (basically identical, except for SMP/ACPI being disabled).
> 
> Thanx!
