Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289094AbSAVA06>; Mon, 21 Jan 2002 19:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289107AbSAVA0s>; Mon, 21 Jan 2002 19:26:48 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:5380 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S289094AbSAVA0j>;
	Mon, 21 Jan 2002 19:26:39 -0500
Message-Id: <5.1.0.14.0.20020122110233.00a1e2e0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 22 Jan 2002 11:26:33 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Athlon PSE/AGP Bug
Cc: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au, andrea@suse.de,
        reid.hekman@ndsu.nodak.edu, alan@lxorg.ukuu.org
In-Reply-To: <20020121.142320.123999571.davem@redhat.com>
In-Reply-To: <3C4C5B26.3A8512EF@zip.com.au>
 <20020121.053724.124970557.davem@redhat.com>
 <20020121175410.G8292@athlon.random>
 <3C4C5B26.3A8512EF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:23 PM 21/01/02 -0800, David S. Miller wrote:
>    I does seem that the nVidia driver is usually involved.
>
>I think this is all "just so happens" personally, and all the that
>turning off the large pages really does is change the timings so that
>whatever bug is really present simply becomes a heisenbug.

I'd definitely agree with that. My home system seems rock stable in regards 
to games. Every game problem I've had I've somehow tracked down to a memory 
leak in the game (or another app running in the background) that 
(assumedly) blew out the VM after a while. (Athlon 1400, Asus A7M, Creative 
SBLive!, Asus V8200 GF3DDR, decent power supply and cooling).

I would not be surprised if some of these "crashes" were power related. 
It's quite possible that by slowing things down (even marginally) it will 
reduce the current drain on the system. Some systems power supplies (and 
associated m/board power circuitry) can be so touchy they become unstable, 
and will eventually provide unclean power (usually an AC ripple on the DC). 
 From there, chaos.

Then you've got heat, which is the "next big killer" with the Athlon's. 
They produce a lot of it, and if it doesn't circulate properly, you can 
never expect anything reliable. Of course, the video card generally is 
quite close to the CPU, and it generates heat too, and can suffer from all 
sorts of issues if they get too hot.

Almost all the Athlon problems I've looked at for friends (with lockups 
specifically) have pretty much fallen into either; the above failure 
categories, "broken hardware" or "kernel issues" (usually known issues, not 
specific to Athlon).

I doubt it's as bad as everyone makes out. Unfortunately people buy cheap 
hardware because it's cheap, not because it's reliable.


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

