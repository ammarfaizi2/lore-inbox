Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUIl1>; Tue, 21 Nov 2000 03:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQKUIlQ>; Tue, 21 Nov 2000 03:41:16 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:28428 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129231AbQKUIlF>;
	Tue, 21 Nov 2000 03:41:05 -0500
Date: Tue, 21 Nov 2000 09:10:54 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: egger@suse.de
Cc: karl.gustav@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: USB: Wacom Graphire mouse wheel does not work anymore
Message-ID: <20001121091054.D599@almesberger.net>
In-Reply-To: <30913.974749254@www23.gmx.net> <20001121021309.F1F145962@Nicole.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001121021309.F1F145962@Nicole.muc.suse.de>; from egger@suse.de on Tue, Nov 21, 2000 at 01:02:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

egger@suse.de wrote:
>> I used the IMPS/2 compatible mouse emulation of the wacom driver
>> (/dev/input/mice).
> 
>  Don't do that. It's evil. Use the xinput driver instead.

Uh, it's not *that* bad ... (what's good: better noise filtering than the
Xinput driver I'm using (xf86Graphireusb.so, June 15, under XF86 3.3.6);
what's bad: only provides mouse).

But anyway, the mouse wheel is also unavailable with the Xinput
driver.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
