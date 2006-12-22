Return-Path: <linux-kernel-owner+w=401wt.eu-S1751750AbWLVLv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWLVLv1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 06:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbWLVLv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 06:51:27 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2547 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbWLVLv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 06:51:27 -0500
Date: Fri, 22 Dec 2006 11:51:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Komal Shah <komal.shah802003@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: omap compilation fixes
Message-ID: <20061222115116.GA961@flint.arm.linux.org.uk>
Mail-Followup-To: Komal Shah <komal.shah802003@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	Vladimir Ananiev <vovan888@gmail.com>
References: <20061222105521.GA23683@elf.ucw.cz> <3a5b1be00612220335l4779089egae0d3270a7c9cd5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5b1be00612220335l4779089egae0d3270a7c9cd5f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 01:35:31PM +0200, Komal Shah wrote:
> On 12/22/06, Pavel Machek <pavel@ucw.cz> wrote:
> >Hi!
> >
> >This is not yet complete set. set_map() is missing in latest kernels.
> >
> >Fix DECLARE_WORK()-change-related compilation problems. Please apply,
> >
> >Signed-off-by: Pavel Machek <pavel@suse.cz>
> >
> 
> Please check linux-omap-open-source mailing list. Some of the build
> breakage patches are already posted regarding to latest kernel sync
> up.
> 
> http://linux.omap.com/pipermail/linux-omap-open-source

There are a set of omap patches in the patch system, but they were too
late for me to merge within the 2 week window - there were additional
delays caused by the accidental attempt to merge the silly ATAG_BOARD
stuff which I had previously refused.

Tony needs to either create a git tree containing strictly just fixes
suitable for -rc kernels, or submit them as individual patches.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
