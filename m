Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTGCJrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 05:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTGCJrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 05:47:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30995 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264647AbTGCJrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 05:47:03 -0400
Date: Thu, 3 Jul 2003 11:01:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: junkio@cox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (trivial 2.5.74) compilation fix drivers/mtd/mtd_blkdevs.c
Message-ID: <20030703110126.C15013@flint.arm.linux.org.uk>
Mail-Followup-To: Juan Quintela <quintela@mandrakesoft.com>, junkio@cox.net,
	linux-kernel@vger.kernel.org
References: <7vbrwc3sxo.fsf@assigned-by-dhcp.cox.net> <86llvgkk59.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <86llvgkk59.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Thu, Jul 03, 2003 at 11:57:22AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 11:57:22AM +0200, Juan Quintela wrote:
> >>>>> "junkio" == junkio  <junkio@cox.net> writes:
> 
> junkio> C does not let us declar variables in the middle of a block (yet).
> 
> It depends what do you call C :)
> 
> C99 does.

Unfortunately gcc 2.95.x does not allow it, so we shouldn't be using it
in the kernel (yet).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

