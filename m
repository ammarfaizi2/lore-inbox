Return-Path: <linux-kernel-owner+w=401wt.eu-S965183AbWLUJws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWLUJws (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWLUJws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:52:48 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4524 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965183AbWLUJwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:52:47 -0500
Date: Thu, 21 Dec 2006 09:52:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH -rt 1/4] ARM: Include compilation and warning fixes
Message-ID: <20061221095239.GB1994@flint.arm.linux.org.uk>
Mail-Followup-To: Dirk Behme <dirk.behme@googlemail.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu
References: <458A4742.3060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458A4742.3060204@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 09:35:14AM +0100, Dirk Behme wrote:
> 
> ARM: Fix compilation issues and warnings for CONFIG PREEMPT
> RT for ARM in include/asm-arm/system.h.
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

Patches like this have been flying around for over a week now, but the
bug's been fixed using a different approach.  Unfortunately, Linus
hasn't pulled the fixes yet, presumably due to being engrossed in
fixing this data corruption issue.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
