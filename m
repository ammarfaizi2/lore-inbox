Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131059AbQLCTjf>; Sun, 3 Dec 2000 14:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131070AbQLCTjY>; Sun, 3 Dec 2000 14:39:24 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:19472 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S131059AbQLCTjP>; Sun, 3 Dec 2000 14:39:15 -0500
Date: Sun, 3 Dec 2000 20:08:47 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: ip_nat_ftp and different ports
Message-ID: <Pine.LNX.4.21.0012032004390.13059-100000@hewpac.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having trouble masquerading ftp-ports other than 20/21.
For some service i'm using, i need to masquerade port 42,43,62,63 for FTP
(I know it's weird...).
Now, when using 2.2.x kernels i could use
'insmod ip_masq_ftp ports=21,41,42,62,63'
but using 2.4.0-testx the 'ports=' parameter doesn't seem to work for
ip_nat_ftp.
Is there any other param I should use (couldn't find it in the docs ;(( )

Please cc me because i'm not on the list (only reading the
web-archives....)

Thanks,
Taco.
---
"I was only 75 years old when I met her and I was still a kid...."
          -- Duncan McLeod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
