Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVLGJYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVLGJYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVLGJYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:24:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2824 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750750AbVLGJYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:24:54 -0500
Date: Wed, 7 Dec 2005 09:24:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051207092446.GA32365@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051205202707.GH15201@flint.arm.linux.org.uk> <20051207075032.5e968a5a.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207075032.5e968a5a.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 07:50:32AM +0100, Jean Delvare wrote:
> What is the new preferred interface? Is it already in mainline or only
> in -mm? I am writing a new platform driver, and am using
> platform_device_interface_simple for now. It works just fine, but if
> it is going to be deprecated soon, I better update my driver before I
> submit it for inclusion.

It is in mainline already - see

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=37c12e7497b6fe2b6a890814f0ff4edce696d862

where you'll find an example usage in the commit comments.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
