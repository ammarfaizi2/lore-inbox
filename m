Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUHKFVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUHKFVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 01:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHKFVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 01:21:19 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:61874 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267806AbUHKFVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 01:21:17 -0400
Date: Wed, 11 Aug 2004 07:20:21 +0200
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Message-ID: <20040811052021.GA8116@gamma.logic.tuwien.ac.at>
References: <20040810171809.GA4217@gamma.logic.tuwien.ac.at> <Pine.LNX.4.44L0.0408101439320.7558-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0408101439320.7558-100000@ida.rowland.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

On Die, 10 Aug 2004, Alan Stern wrote:
> Maybe the -mm series didn't get my USB device locking patches fully
> reverted.  They certainly didn't get fully corrected, because the patch
> for that was never accepted.  Your traces do make it look as though this
> is the problem.
> 
> Check in drivers/usb/core/usb.c and see if it mentions
> usb_all_devices_rwsem anywhere.  I'd do it myself, but I don't know _any_

Not there, nowhere. Nothing with rwsem at all.

So we are back to a zero start again?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
The story goes that I first had the idea for THHGTTG while
lying drunk in a field in Innsbruck (or `Spain' as the BBC
TV publicity department authorititively has it, probably
because it's easier to spell).
                 --- Foreward by DNA.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
