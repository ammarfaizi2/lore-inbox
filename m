Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUJULjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUJULjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270712AbUJULhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:37:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5642 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269083AbUJUJue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:50:34 -0400
Date: Thu, 21 Oct 2004 10:50:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Am I paranoid or is everyone out to break my kernel builds (Breakage in drivers/pcmcia)
Message-ID: <20041021105026.C3089@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <20041021100903.A3089@flint.arm.linux.org.uk> <20041021023135.074c7988.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041021023135.074c7988.akpm@osdl.org>; from akpm@osdl.org on Thu, Oct 21, 2004 at 02:31:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:31:35AM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > Take special note of the '&' before 'num' in the above initialiser, and
> > check the structure:
> 
> Something's out of whack with your tree.  You should have:

Ok, but what's the point of the change?  If it's to indicate that
we're returning a value, shouldn't the other module_param* macros
also be fixed in the same way, or do we just like special cases?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
