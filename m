Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSBMNPa>; Wed, 13 Feb 2002 08:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbSBMNPU>; Wed, 13 Feb 2002 08:15:20 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:42971 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S274862AbSBMNPI>; Wed, 13 Feb 2002 08:15:08 -0500
Date: Wed, 13 Feb 2002 07:14:45 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: "Proescholdt, timo" <Timo.Proescholdt@brk-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: randomness - compaq smart array driver
Message-ID: <20020213071445.A20717@asooo.flowerfire.com>
In-Reply-To: <410B51F29EA8D3118EE400508B44AE2B3C6FB3@RZ_NT_MAIL> <Pine.LNX.4.33.0202111754560.5685-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202111754560.5685-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Mon, Feb 11, 2002 at 05:58:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I've been using the netdev patches for months.  Aside from the
unrelated entropy exhaustion bug, his patches are stable (and optional)
and help on diskless or low-I/O machines.  2.4 or 2.5 anyone? :)
-- 
Ken.
brownfld@irridia.com

On Mon, Feb 11, 2002 at 05:58:37PM +0100, Tim Schmielau wrote:
| On Mon, 11 Feb 2002, Proescholdt, timo wrote:
| 
| > I noticed that the installation fails due to missing randomness.
| > I can confirm that as cat /dev/random does not provide any output.
| [...]
| > I heard that there is a patch for 2.2.x kernels, wich deals with this
| > topic , but i cannot find this patch anywere .
| > Is there a similar patch for 2.4.x kernels?
| 
| Robert Love did a patch to let network devices contribute to the random
| pool. Look at
|   ftp://www.*.kernel.org/pub/linux/kernel/people/rml/netdev-random/
| or
|   http://www.tech9.net/rml/linux/
| 
| Tim
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
