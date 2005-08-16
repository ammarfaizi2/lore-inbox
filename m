Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbVHPUxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVHPUxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbVHPUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:53:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56840 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932708AbVHPUxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:53:43 -0400
Date: Tue, 16 Aug 2005 21:53:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: James.Smart@Emulex.Com, James.Bottomley@SteelEye.com, matthew@wil.cx,
       greg@kroah.com, akpm@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] add transport class symlink to device object
Message-ID: <20050816215329.B14055@flint.arm.linux.org.uk>
Mail-Followup-To: Luben Tuikov <luben_tuikov@adaptec.com>,
	James.Smart@Emulex.Com, James.Bottomley@SteelEye.com,
	matthew@wil.cx, greg@kroah.com, akpm@osdl.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD39@xbl3.ma.emulex.com> <4301EC0E.6090406@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4301EC0E.6090406@adaptec.com>; from luben_tuikov@adaptec.com on Tue, Aug 16, 2005 at 09:37:18AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 09:37:18AM -0400, Luben Tuikov wrote:
> On 08/15/05 20:52, James.Smart@Emulex.Com wrote:
> > My vote is to make the multiplexor instantiate each serial line
> > as a separate device.
> 
> Yes, you're absolutely and completely correct.  I think the same
> way as you do.

Just don't expect it to happen any time in the next fortnight, even
if 2.6.13 were to appear tomorrow.  Firstly, I have the parport_serial
patches queued up since god knows when (a month or so back now I
think.)  Secondly I'm not around next week so I probably won't have
time to do anything with serial in the non-rc part of the 2.6.14
cycle.

Therefore, I think this will have to wait for 2.6.14 or so.  Sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
