Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVLLVxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVLLVxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVLLVxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:53:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932074AbVLLVxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:53:08 -0500
Date: Mon, 12 Dec 2005 21:53:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-ID: <20051212215259.GE19481@flint.arm.linux.org.uk>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20051212134904.225dcc5d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212134904.225dcc5d.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 01:49:04PM -0800, Pete Zaitcev wrote:
> Do you have a suggestion about the fastest way to accomplish the same
> effect with ub?

Note: same thing happens with floppy if you have two floppy drives
connected to the controller.  You end up with two "block" symlinks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
