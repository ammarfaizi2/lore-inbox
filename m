Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWGBU3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWGBU3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWGBU3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 16:29:16 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:61146 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750717AbWGBU3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 16:29:15 -0400
Date: Sun, 02 Jul 2006 16:29:01 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <adad5cnderb.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, Ken Brush <kbrush@gmail.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Message-id: <1151872141.3285.486.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<adad5cnderb.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 11:48 -0700, Roland Dreier wrote:
> this works well on my kyocera kpc650 -- throughput is up to about 1
> mbit/sec vs. ~250 kbit/sec with the stock airprime driver.
> -
Thanks for the feedback.

I'm working on fixing the concerns Andrew Morton expressed regarding
memory leaks in the open function. I'll send an updated driver soon.

BTW - Jeremy suggested that the number of EPs to configure should be
determined from the device ID. Makes sense to me, but then many users
may have no use for the additional EPs. Alternatively, Greg suggested
that maybe this should split into 2 drivers. Any preferences, anyone?

I don't know which of these devices present multiple EPs though. Can you
send me the appropriate section from 'cat /proc/bus/usb/devices'?

Anyone with an actual Airprime (ID 0xf3d, 0x0112) or Novatel Merlin
(0x1410, 0x1110) please do the same.

Thanks -
Andy



