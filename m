Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUCEI0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 03:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUCEI0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 03:26:43 -0500
Received: from styx.suse.cz ([82.208.2.94]:20352 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S262256AbUCEI0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 03:26:41 -0500
Date: Fri, 5 Mar 2004 09:26:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix i8042 PS/2 mouse on ARM
Message-ID: <20040305082640.GC236@ucw.cz>
References: <20040304192257.A13227@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304192257.A13227@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 07:22:57PM +0000, Russell King wrote:
> Vojtech,
> 
> This patch is required on ARM so that we pick up the correct AUX
> interrupt number.  Some machines (eg, NetWinders) use IRQ5 instead
> of IRQ12 for the PS/2 mouse.
> 
> Please comment, and let me know if you're happy to apply it, or
> whether you're happy for me to do so.
> 
> Thanks.

Applied to my tree, thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
