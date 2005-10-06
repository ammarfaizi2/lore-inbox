Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVJFVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVJFVTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVJFVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:19:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56845 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750852AbVJFVTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:19:44 -0400
Date: Thu, 6 Oct 2005 22:19:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Get rid of the obsolete tri-level suspend/resume callbacks (was: Re: [PATCH/RFC 1/2] simple SPI framework)
Message-ID: <20051006211937.GC5312@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051005143946.7D9C9EE8EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20051006182349.7430.qmail@web33007.mail.mud.yahoo.com> <20051006182938.GA5312@flint.arm.linux.org.uk> <20051006190234.GB5312@flint.arm.linux.org.uk> <20051006211433.GB27711@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006211433.GB27711@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 11:14:33PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Here's a patch to illustrate what I mean.
> 
> Nice, _very_ nice. It broke compilation at two places... Here are fixes.

Thanks for testing Pavel.  I've added this to the patch.  Obviously
I'll hold off the patch until 2.6.14 has happened.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
