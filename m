Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWATIsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWATIsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWATIsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:48:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11792 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750704AbWATIsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:48:05 -0500
Date: Fri, 20 Jan 2006 08:47:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "L. A. Walsh" <lkml@tlinx.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060120084756.GA23459@flint.arm.linux.org.uk>
Mail-Followup-To: "L. A. Walsh" <lkml@tlinx.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <20060117183916.399b030f.diegocg@gmail.com> <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org> <Pine.LNX.4.61.0601172104350.11929@yvahk01.tjqt.qr> <69304d110601171304h34c16fbfuf59df390c0fc58fd@mail.gmail.com> <Pine.LNX.4.61.0601172259410.7756@yvahk01.tjqt.qr> <43D09C21.6030607@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D09C21.6030607@tlinx.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 12:15:29AM -0800, L. A. Walsh wrote:
>    That seems a bit unproductive given the amount of patches
> that get sent to the list. It would be easier for senders
> and, likely, readers to sort through topics if people could
> put patches in 1 post rather than sending 10-20 consecutive
> "[PATCH XX/30]"...

That's not the (main) reason why patches get split up.  They're
split up into logical incremental changes to aid review.

Also, you should be able to apply the first half of the patch set
and get a working kernel - this aids debugging since you can find
the small set of changes which caused the problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
