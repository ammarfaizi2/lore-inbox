Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbVJ1T5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVJ1T5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbVJ1T5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:57:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17168 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030454AbVJ1T5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:57:05 -0400
Date: Fri, 28 Oct 2005 20:56:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [PATCH] pci device wakeup flags
Message-ID: <20051028195654.GH4464@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, gregkh@suse.de,
	linux-kernel@vger.kernel.org, david-b@pacbell.net
References: <11304810221338@kroah.com> <11304810223093@kroah.com> <20051028035116.112ba2ca.akpm@osdl.org> <20051028155044.GA11924@kroah.com> <20051028123434.09c5cb2f.akpm@osdl.org> <Pine.LNX.4.64.0510281247010.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510281247010.4664@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:45:28PM -0700, Greg KH wrote:
> Ugh, ok, at least I wasn't that far off.  I'll make sure to not send the
> usb pm patches in the round of usb updates until that gets figured out.

On Fri, Oct 28, 2005 at 12:47:50PM -0700, Linus Torvalds wrote:
> Just to verify: that one isn't in the current driver core tree, right? I 
> assume that's in Greg's USB tree..

Greg,

Any chance of putting my driver model changes into the driver core tree?
ISTR the reason they ended up in the USB tree was because they clashed
with the usb-pm patches.  However, if the usb-pm patches are
problematical, I'd rather my driver model changes weren't held up.

Alternatively, I could ask Linus to take them directly from me if
you're happy for that to happen.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
