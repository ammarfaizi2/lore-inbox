Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272592AbRIVUjp>; Sat, 22 Sep 2001 16:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272118AbRIVUjd>; Sat, 22 Sep 2001 16:39:33 -0400
Received: from kuma.unm.edu ([129.24.9.36]:64193 "HELO kuma.unm.edu")
	by vger.kernel.org with SMTP id <S272092AbRIVUjS>;
	Sat, 22 Sep 2001 16:39:18 -0400
Date: Sat, 22 Sep 2001 14:39:43 -0600 (MDT)
From: Todd <todd@unm.edu>
To: Colin Frank <kernel@osafo.com>
cc: Abe Hayhurst <abe@avidsublimation.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Best gigabit card for linux
In-Reply-To: <3BAC153A.4060700@osafo.com>
Message-ID: <Pine.A41.4.33.0109221427110.32830-100000@aix15.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

colin,

40 MBytes per second?  that's not really very good for a gigabit card.
(32% of line speed).  our experience with the 2.4 kernel (pre-zerocopy)
has been that we can get 99.3% (around 125 MBytes/sec) before cpu
utilization gets to 100%.  this was using acenic's (now 3com but 3com
appears to not be selling them.  sigh.).

todd underwood
todd@unm.edu

On Fri, 21 Sep 2001, Colin Frank wrote:

> Date: Fri, 21 Sep 2001 21:36:10 -0700
> From: Colin Frank <kernel@osafo.com>
> To: Abe Hayhurst <abe@avidsublimation.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Best gigabit card for linux
>
>
> In the following test. I was able to achieve close to 40 MegaBytes
> per second using the packet engines Hamachi driver.
>
> http://www.linuxcare.com/labs/sol-val/3w-esc6800-web.epl
> Test done with:
>     Packet engines Hamachi card
>     3ware escalade 6800
>     2.2.16 kernel.
>     Cisco 6500
>     10 - 20 client machines each with eepro100 cards
>
> Colin...
>
> Abe Hayhurst wrote:
>
> >Hi Alan,
> >
> >I wanted to know your opinion as to which combination of gigabit cards (both
> >fiber and copper) and drivers would yield the best performance (mostly
> >transferring large files from server to client, but also latency) in Linux.
> >I am not a programmer, a kernel tweaker, or a driver developer. I need a
> >card that either has a driver that comes with Red Hat Linux 7.1 or is easy
> >to install and needs minimal tweaks to the driver. I am currently
> >considering cards from 3Com (Alteon), Broadcom, Intel, and SysKonnect.
> >
> >Thanks for your help,
> >
> >Abe Hayhurst
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

=========================================================
Todd Underwood, todd@unm.edu

=========================================================

