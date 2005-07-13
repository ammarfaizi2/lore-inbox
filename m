Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVGMGMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVGMGMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 02:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGMGMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 02:12:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262486AbVGMGMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 02:12:54 -0400
Date: Wed, 13 Jul 2005 07:12:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Song <samlinuxkernel@yahoo.com>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050713071245.B19871@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Song <samlinuxkernel@yahoo.com>, david-b@pacbell.net,
	linux-kernel@vger.kernel.org
References: <20050712130119.A30358@flint.arm.linux.org.uk> <20050713045522.99423.qmail@web32011.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050713045522.99423.qmail@web32011.mail.mud.yahoo.com>; from samlinuxkernel@yahoo.com on Tue, Jul 12, 2005 at 09:55:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 09:55:22PM -0700, Sam Song wrote:
> But seems not functional on PowerPC platform. I used
> a MPC8241 which has a DURT inside to try the git tree
> 8250.c and got the following result:

I don't know what's going on here - I don't know the PPC code
internals at all, or what you're running.

However, if you merely lifted the later 8250.c and put it into a
previous kernel (which looks like the case), there's other changes
in addition which are required.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
