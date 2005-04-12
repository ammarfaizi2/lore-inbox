Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbVDLVKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVDLVKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVDLVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:03:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262152AbVDLUzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:55:32 -0400
Date: Tue, 12 Apr 2005 21:55:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: incoming
Message-ID: <20050412215526.B11984@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20050412032322.72d73771.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050412032322.72d73771.akpm@osdl.org>; from akpm@osdl.org on Tue, Apr 12, 2005 at 03:23:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 03:23:22AM -0700, Andrew Morton wrote:
> As the commits list probably isn't working at present I'll cc linux-kernel
> on this lot.  Fairly cruel, sorry, but I don't like the idea of people not
> knowing what's hitting the main tree.

I don't see a patch which adds linux/pm.h to linux/sysdev.h, which is
required to fix ARM builds in -rc2 and onwards kernels.

It is my understanding that you have such a patch, and if it isn't
going to be sent, I'd like to send my own fix so that ARM can start
building again in mainline.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
