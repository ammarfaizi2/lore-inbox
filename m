Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUCCWZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUCCWZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:25:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261210AbUCCWY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:24:58 -0500
Date: Wed, 3 Mar 2004 22:24:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
Message-ID: <20040303222454.A15007@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <10782873992219@kroah.com> <10782873993395@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10782873993395@kroah.com>; from greg@kroah.com on Tue, Mar 02, 2004 at 08:16:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 08:16:39PM -0800, Greg KH wrote:
> ChangeSet 1.1612.24.4, 2004/03/02 16:39:36-08:00, greg@kroah.com
> 
> Driver core: add CONFIG_DEBUG_DRIVER to help track down driver core bugs easier.

Wouldn't a cleaner way to do this be to add -DDEBUG to EXTRA_CFLAGS
in the makefile if CONFIG_DEBUG_DRIVER is set, and remove the #undef
DEBUG statements in each .c file?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
