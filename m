Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUFRQfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUFRQfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUFRQfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:35:03 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:4558 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266175AbUFRQeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:34:50 -0400
Date: Fri, 18 Jun 2004 12:28:25 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
In-Reply-To: <pan.2004.06.18.06.08.03.257944@smurf.noris.de>
Message-ID: <Pine.GSO.4.33.0406181221310.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Matthias Urlichs wrote:
>>>Current sda: sense key Medium Error
>
>>There's likely nothing wrong with your drives.  Something about that
>>driver and the hardware aren't playing nice.
>
>What does the drive's SMART error log report?

No errors.

>I would consider swapping the power supply. Last year I had *four* 120 GB
>drives fail on me before I changed the thing. Zero problems since.

Moral: stop buying crappy power supplies. :-)

My power supply is fine.  If the PS were at fault, the same thing would
be happening all the time, not just when linux tries to throw 200 sectors
at a time at the drives.  Windows has been stressing these drives far more
than linux and there's been zero idication of any problems.  As I said,
writing in O_DIRECT mode to the array @ _35MB/s_ never reports a DMA
timeout -- I'll start increasing the buffer size to see where the cracking
point is.

--Ricky


