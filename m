Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSDVHfU>; Mon, 22 Apr 2002 03:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314081AbSDVHfU>; Mon, 22 Apr 2002 03:35:20 -0400
Received: from w226.z064000207.nyc-ny.dsl.cnc.net ([64.0.207.226]:25140 "EHLO
	carey-server.stronghold.to") by vger.kernel.org with ESMTP
	id <S314080AbSDVHfS>; Mon, 22 Apr 2002 03:35:18 -0400
Message-Id: <4.3.2.7.2.20020422033757.03b9a5e0@mail.strongholdtech.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 22 Apr 2002 03:40:41 -0400
To: "Steve Wolfe" <sw@codon.com>, <linux-kernel@vger.kernel.org>
From: "Nicolae P. Costescu" <nick@strongholdtech.com>
Subject: Re: AMD 760MPX B2 stepping
In-Reply-To: <000f01c1e659$17abd6e0$d281f6cc@iboats.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve
Just put 3 of these together and they seem to work fine (Tyan 2466N-4M, 
2x1.6GHz Athlon MP processors - make sure you are using MP and not XP - 
Tyan won't certify the XP for SMP and a lot of people complain about 
stability with the XPs in an SMP config).

There is a catch - they only work with "single bank" dimms (64x4 for 512MB 
dimm). The vendor shipped me a mix of 64x4 and 32x8 512MB dimms, and the 
32x8's would not even POST. Tyan's web site indicates the board should work 
with the 32x8 as well (in fact they list the ATP/Samsung part # of the 
DIMMs I was sent, both 64x4 and 32x8). However, since I've tried 6 DIMMS 
and 3 motherboards, I feel confident in saying they are WRONG :)

Good luck.
Nick

At 03:44 PM 4/17/2002 -0600, Steve Wolfe wrote:

>    I have been having a devil of a time trying to get SMP to work with
>stability on the new B2 stepping of the 760 MPX chipset (Tyan 2466N-4M
>motherboard).  Has anyone fiddled with it, and if so, are there any known
>bugs?  My gut feeling is that the BIOS included with the motherboard is
>incredibly buggy, but I haven't been able to find any information to
>confirm or contradict that.
>
>steve
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

****************************************************
Nicolae P. Costescu, Ph.D.  / Senior Developer
Stronghold Technologies
46040 Center Oak Plaza, Suite 160 / Sterling, Va 20166
Tel: 571-434-1472 / Fax: 571-434-1478

