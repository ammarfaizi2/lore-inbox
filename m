Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRAEVEU>; Fri, 5 Jan 2001 16:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRAEVEK>; Fri, 5 Jan 2001 16:04:10 -0500
Received: from smtp3.libero.it ([193.70.192.53]:29319 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S129538AbRAEVEB>;
	Fri, 5 Jan 2001 16:04:01 -0500
Date: Sat, 6 Jan 2001 00:04:29 +0100
From: antirez <antirez@invece.org>
To: Greg KH <greg@wirex.com>, Heitzso <xxh1@cdc.gov>,
        "'antirez@invece.org'" <antirez@invece.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: Re: USB broken in 2.4.0
Message-ID: <20010106000429.K7784@prosa.it>
Reply-To: antirez@invece.org
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F99@mcdc-atl-5.cdc.gov> <20010105100040.A25217@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010105100040.A25217@wirex.com>; from greg@wirex.com on Fri, Jan 05, 2001 at 10:00:40AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 10:00:40AM -0800, Greg KH wrote:
> I made the same request to Jordan Mendelson yesterday, who has the same
> problem.  Could you be so kind as to try to narrow down which kernel
> version this broke on?  I have reports that it used to work on -test9
> but doesn't now.  Could you try -test10, etc and let me know?

I'll do some test with the new 2.4 kernel to find if there is a problem
in s10sh itself. A good test can be to try if the equivalent driver
of gphoto works without problems using the 2.4 kernel (however it also
uses the libusb). The s10sh bug may be not necessarly related to the USB
subsystem.

regards,
antirez

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
