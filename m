Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVGOU6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVGOU6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVGOU6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:58:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38155 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261203AbVGOU6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:58:49 -0400
Date: Fri, 15 Jul 2005 21:58:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
Message-ID: <20050715215845.D23709@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20050715213058.B23709@flint.arm.linux.org.uk> <NDBBKFNEMLJBNHKPPFILAEAMCEAA.karl@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBKFNEMLJBNHKPPFILAEAMCEAA.karl@petzent.com>; from karl@petzent.com on Fri, Jul 15, 2005 at 01:52:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:52:15PM -0700, karl malbrain wrote:
> On my 2.6.9-11EL source it clearly shows the up(&tty_sem) after the call to
> uart_open. Init_dev never touches tty_sem.

In which case, I have to say...

Congratulations!  You've found a bug with Red Hat's Enterprise Linux
kernel!  Go straight to Red Hat's bugzilla!  Do not collect 200$.  Do
not pass go.

Seriously though, this bug is not present in mainline kernels, so I
can't resolve this issue for you.  Mainline kernels appear to work
properly.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
