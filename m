Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279714AbRJYFzl>; Thu, 25 Oct 2001 01:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279715AbRJYFzc>; Thu, 25 Oct 2001 01:55:32 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:261 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279714AbRJYFzO>;
	Thu, 25 Oct 2001 01:55:14 -0400
Message-Id: <5.1.0.14.0.20011025154916.00a1c250@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Oct 2001 15:55:44 +1000
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS/Trident 4DWave sound driver oops
Cc: "Michael F. Robbins" <compumike@compumike.com>
In-Reply-To: <1003972047.2393.9.camel@tbird.robbins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:07 PM 24/10/01 -0400, Michael F. Robbins wrote:
>I also have a totally reproduceable OOPS on 2.4.9 through 2.4.12.
>Kernel 2.4.7 works just fine.  If the soundcard is compiled in to the
>kernel, it dies while booting.  If it is compiled as a module, it dies
>when attempting to load the module (typically when artsd starts).

I just tried 2.4.7, and while the module loads, the ac97_codec gives an 
"unknown id" response, and I get no sound out of the device whatsoever. Any 
writes to /dev/dsp just hang (not the kernel) and I get nothing out of the 
device.

I might try compiling the 2.4.7 trident module without symbol versions, and 
a 2.4.9 kernel the same, and try forcibly inmod'ing the 2.4.7 trident 
module on 2.4.9 and see what happens.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

