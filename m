Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSBILzL>; Sat, 9 Feb 2002 06:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288914AbSBILzC>; Sat, 9 Feb 2002 06:55:02 -0500
Received: from pop.gmx.de ([213.165.64.20]:64681 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288878AbSBILyp>;
	Sat, 9 Feb 2002 06:54:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: sonypi in 2.4.18-pre9
Date: Sat, 9 Feb 2002 12:48:34 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020209115453Z288878-13996+19685@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great I just want to say that sonypi in 2.4.18-pre9 works fine.
I have a vaio pcg qr10. This is the first kernel Version in which I can 
changing the background lite.

Just one Problem. Maybe a spicctrl Problem but if I try to get infos like:
spicctrl -p
BAT1: 2202/2479 88.83%

It works fine.

But sometimes (every 10 times) I get this:
BAT1: 2191/44975 4.87%

Or:

spicctrl -B
1

and than
spicctrl -B
100 (the right one)

As you can see I can get the battery status from spicctrl. But apm can't get 
the status, is there a way to enable apmd to use sonypi, or work correct.
This is the output from /proc/apm:
1.16 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

At this time there was no AC only battery
spicctrl -p shows this:
BAT1: 2120/2479 85.52%

Is there a way to help you to get this problem fixed (I mean debug infos or 
something like this ;)

thanks

have fun
HAL
