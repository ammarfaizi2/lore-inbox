Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752354AbWAGOtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbWAGOtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbWAGOtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:49:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2573 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752354AbWAGOtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:49:45 -0500
Date: Sat, 7 Jan 2006 14:49:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: 2.6-git: BITS_PER_LONG
Message-ID: <20060107144940.GE31384@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Christoph Lameter <clameter@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

With the latest git, I'm seeing a number of:

include/asm-generic/atomic.h:20:5: warning: "BITS_PER_LONG" is not defined

What's intended here?  Should asm-generic/atomic.h include asm/types.h?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
