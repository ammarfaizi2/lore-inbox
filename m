Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278862AbRJ1XG0>; Sun, 28 Oct 2001 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278867AbRJ1XGR>; Sun, 28 Oct 2001 18:06:17 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:28933 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S278862AbRJ1XGI>;
	Sun, 28 Oct 2001 18:06:08 -0500
Message-Id: <5.1.0.14.0.20011029095844.01f60df0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Oct 2001 10:06:40 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS/Trident 4DWave sound driver
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        compumike@compumike.com (Michael F. Robbins),
        rml@tech9.net (Robert Love),
        tachino@open.nm.fujitsu.co.jp (Tachino Nobuhiro)
In-Reply-To: <E15x86H-0000GV-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.0.20011026125325.024517e0@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:36 PM 26/10/01 +0100, Alan Cox wrote:
> > though the codec->codec_read(codec, AC97_VENDOR_ID#) isn't returning the
> > codec value for this system at all.
>
>Something is failing to bring up the AC97 codec bus and/or set it up
>properly. Can you find exactly which patch broke that for you (you'll
>possibly want to keep fixing the codec table as you test older ones)

Well the thing is this system has never had working sound. I've got 2 of 
these machines, both with the array fix, and neither get sound. I've tried 
2.4.7 (which didn't have the array fix), 2.4.9, 2.4.12, 2.4.13, and I'm 
about to try some earlier kernels, but since this chip is "notoriously new" 
I would not be suprised if it's not returning anything for what should be 
valid codec calls. Will take a peek and get back to you.

PS: This is one of these SiS630S all in one integrated things, and also one 
of the offenders in that SiS FrameBuffer stuff we've been discussing, so I 
wouldn't be suprised in anomalies at all.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

