Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRJUSoU>; Sun, 21 Oct 2001 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276558AbRJUSnB>; Sun, 21 Oct 2001 14:43:01 -0400
Received: from [213.97.45.174] ([213.97.45.174]:19463 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S276538AbRJUSm2>;
	Sun, 21 Oct 2001 14:42:28 -0400
Date: Sun, 21 Oct 2001 20:42:47 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Roel Teuwen <Roel.Teuwen@advalvas.be>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Xircom card problems on apm resume (xirc2ps_cs)
In-Reply-To: <1003659714.1087.17.camel@omniroel>
Message-ID: <Pine.LNX.4.33.0110212038130.2316-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Oct 2001, Roel Teuwen wrote:

> When resuming after an apm -s, my xircom card (REM56G-100) is no longer
> functional. I need to ifdown,rmmod,modprobe,ifup in order to get it to
> work again.

Exactly the same happens to me. I have to remove and reinsert the card tom 
make it work again. kbdrate is lost too.

> I am running kernel 2.4.12-ac3, but I haven't found a past 2.4 kernel
> (yet) that makes this work without problems.

Has happened always for me for all kind of network cards and kernels that 
I have tried.

> Maybe unrelated, on this laptop the apm -s command only succeeds when it
> is running on battery power, trying to suspend with the AC cord plugged
> in causes it to resume (if it ever suspends at all) nearly instantly.

If you are on AC power it does not stop the first time, it just hungs for 
a while. When it comes back to life in about 40-60 seconds, maybe the next 
try to supsend works.

When waking up, sometime the X screen does not appear; I have to go to the 
BIOS setup screen and exit to get it back. I used to reboot til I 
discovered the trick.

Pau

