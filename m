Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRHTVGU>; Mon, 20 Aug 2001 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269387AbRHTVGK>; Mon, 20 Aug 2001 17:06:10 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:57231 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269385AbRHTVGA>; Mon, 20 Aug 2001 17:06:00 -0400
Date: Mon, 20 Aug 2001 17:06:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: t.sailer@alumni.ethz.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for bizzare oops in USB
Message-ID: <20010820170614.A28653@devserv.devel.redhat.com>
In-Reply-To: <20010818013101.A7058@devserv.devel.redhat.com> <3B80FBA9.556B7B2B@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B80FBA9.556B7B2B@scs.ch>; from sailer@scs.ch on Mon, Aug 20, 2001 at 01:59:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 20 Aug 2001 13:59:37 +0200
> From: Thomas Sailer <sailer@scs.ch>

> This is bad for other users of usb_control_msg/usb_bulk_msg that depend on
> the sleep to be interruptible.

Would you mind to explain how a user of usb_control_msg may
depend on the sleep being interruptible? Forgets to set a timeout?
Actually, I rethought the problem and I have a better fix,
but for an different reason entirely. A user of usb_control_msg
who knows too much about usb_control_msg still sounds fishy to me.

-- Pete
