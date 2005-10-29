Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVJ2VSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVJ2VSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 17:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVJ2VSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 17:18:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16141 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751238AbVJ2VSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 17:18:43 -0400
Date: Sat, 29 Oct 2005 22:18:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Roland Dreier <rolandd@cisco.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Move platform device to separate header
Message-ID: <20051029211837.GH14039@flint.arm.linux.org.uk>
Mail-Followup-To: Roland Dreier <rolandd@cisco.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051029205207.GG14039@flint.arm.linux.org.uk> <52oe58nirh.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52oe58nirh.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 01:57:38PM -0700, Roland Dreier wrote:
>     Russell> Here's a patch which moves the platform device out of
>     Russell> device.h and into linux/platform_device.h.  This patch is
>     Russell> far too large for lkml so can be downloaded from:
> 
> It looks like you forgot to diff <linux/platform_device.h>.  It
> doesn't appear in your diffstat and as far as I can tell, it's not in
> the actual diff either.

/me hates cg-commit...

I also didn't give the commit message a proper header line.  Gah.
Fixed, new patch uploaded, thanks for spotting.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
