Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135867AbREABJy>; Mon, 30 Apr 2001 21:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135926AbREABJo>; Mon, 30 Apr 2001 21:09:44 -0400
Received: from cs.columbia.edu ([128.59.16.20]:15608 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135867AbREABJZ>;
	Mon, 30 Apr 2001 21:09:25 -0400
Date: Mon, 30 Apr 2001 18:09:23 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0104301623070.530-100000@viper.haque.net>
Message-ID: <Pine.LNX.4.33.0104301649471.12259-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Mohammad A. Haque wrote:

> Just to give another data point...
> 
> 2.2.19 + LVM patches - dual P3 550
> 1 GB RAM
> eepro100
> ncr53c8xx scsi
> mylex accelRAID 1100 RAID controller
> 
> We've transferred around 1 GB of stuff over the network and about 200 GB
> between two raids w/o problems in a little under 3 days.
> 
> We've only scratched into swap. Free show 128K being used.

Ok. Have you tried running a large bonnie (1GB) while at the same time 
pummeling the network? That's how I trigger it, quite reliably.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


