Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269759AbUJGJOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269759AbUJGJOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUJGJOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:14:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12813 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269759AbUJGJOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:14:44 -0400
Date: Thu, 7 Oct 2004 10:14:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: todd nguyen <toddnguyen@yahoo.com>
Cc: linux-kernel@vger.kernel.org, majordomo@vger.kernel.org
Subject: Re: Oops in loading cardbus bridge drivers in kernel version 2.6.9-rc1
Message-ID: <20041007101438.B10716@flint.arm.linux.org.uk>
Mail-Followup-To: todd nguyen <toddnguyen@yahoo.com>,
	linux-kernel@vger.kernel.org, majordomo@vger.kernel.org
References: <20041006225645.43733.qmail@web11204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041006225645.43733.qmail@web11204.mail.yahoo.com>; from toddnguyen@yahoo.com on Wed, Oct 06, 2004 at 03:56:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 03:56:45PM -0700, todd nguyen wrote:
> " Unable to handle kernel NULL pointer dereference at
> virtual address 00000008"  Can anyone give me some
> pointer on why I'm seeing this error?

Something for the PCI people to look at I think...  However, you might
consider including _full_ lspci -vv information rather than just a
subset.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
