Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRAUFlD>; Sun, 21 Jan 2001 00:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135423AbRAUFkn>; Sun, 21 Jan 2001 00:40:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131563AbRAUFkm>; Sun, 21 Jan 2001 00:40:42 -0500
Message-ID: <3A6A7639.7F4A0A21@transmeta.com>
Date: Sat, 20 Jan 2001 21:40:09 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Device List Maintainer <device@lanana.org>
Subject: Re: Minors remaining in Major 10 ??
In-Reply-To: <Pine.LNX.4.10.10101201651070.657-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Hi Peter,
> 
> Regardless if we rip out the entire rule of majors for dev_t, will there
> be a service dummy driver to various block-devices?  There is a real need
> for this if we are going to get full control of the hardware by indirect
> access obtain the functionality that I see and need in the near future.
> 

At this point, I'll allocate a device number when someone is ready to
release a driver - no sooner.  There simply is not a whole lot of choice
because of the extreme shortage of device numbers that's going to last us
until dev_t gets expanded.

	-hpad


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
