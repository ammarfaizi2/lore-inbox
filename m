Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUHaWBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUHaWBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUHaUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:06:00 -0400
Received: from lists.us.dell.com ([143.166.224.162]:32157 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S267380AbUHaUBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:01:16 -0400
Date: Tue, 31 Aug 2004 14:59:02 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Adrian Yee <brewt-linux-kernel@brewt.org>
Cc: Eric Mudama <edmudama@gmail.com>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HDD LED doesn't light.
Message-ID: <20040831195902.GA3945@lists.us.dell.com>
References: <311601c904082709107a8c8475@mail.gmail.com> <GMail.1093981448.21536945.017857081112@brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GMail.1093981448.21536945.017857081112@brewt.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 12:44:08PM -0700, Adrian Yee wrote:
> But this doesn't explain why I have two motherboards here where the HDD
> activity LED does not light up in linux (for SATA drives) but does in
> windows .  Note that it only starts working in windows *after* the
> driver has loaded.

I've heard of implementations of the drive light on SATA where it is
controlled through a general-purpose I/O pin somewhere else in the
chipset.  If that's the case, then the Windows driver may well know
how to drive the GPIO to indicate drive activity for you...

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
