Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135239AbRD3U3W>; Mon, 30 Apr 2001 16:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135283AbRD3U3M>; Mon, 30 Apr 2001 16:29:12 -0400
Received: from viper.haque.net ([66.88.179.82]:20887 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135239AbRD3U3K>;
	Mon, 30 Apr 2001 16:29:10 -0400
Date: Mon, 30 Apr 2001 16:28:59 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0104301255020.12259-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.33.0104301623070.530-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Ion Badulescu wrote:

> Except that the only driver I'm using is eepro100, and the only change to
> that driver was the patch I submitted myself and which is also in 2.4.
>
> Also, another data point: those two SMP boxes have been running 2.2.18 +
> Andrea's VM-global patch since January, without a hitch.
>
> Ok, so onto the binary search through the 2.2.19pre series...

Just to give another data point...

2.2.19 + LVM patches - dual P3 550
1 GB RAM
eepro100
ncr53c8xx scsi
mylex accelRAID 1100 RAID controller

We've transferred around 1 GB of stuff over the network and about 200 GB
between two raids w/o problems in a little under 3 days.

We've only scratched into swap. Free show 128K being used.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

