Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282687AbRLDIve>; Tue, 4 Dec 2001 03:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282685AbRLDIvO>; Tue, 4 Dec 2001 03:51:14 -0500
Received: from tourian.nerim.net ([62.4.16.79]:4104 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S282679AbRLDIvN>;
	Tue, 4 Dec 2001 03:51:13 -0500
Message-ID: <3C0C8E7F.2080007@free.fr>
Date: Tue, 04 Dec 2001 09:51:11 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011203
X-Accept-Language: en-us
MIME-Version: 1.0
To: Cheryl Homiak <chomiak@chartermi.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via82cxx chipset problem
In-Reply-To: <Pine.LNX.4.40.0112030943110.223-100000@maranatha.chartermi.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cheryl Homiak wrote:

> I tried this question on another list and was told not to try to change my
> mhz speed because I would corrupt my hard drive possibly. But does this
> mean I am actually running at only 33mhz.?


Your PCI bus is most probably running at 33 Mhz. As it is intended to 
run at this speed. There's nothing wrong with that. The :
"ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx"
message is a warning that the PCI bus speed cannot be reliably detected.

For IDE PIO transfer modes the PCI bus speed is a reference which is 
used by timers which regulate IO transfers. As some computers run the 
PCI bus at other frequencies, mainly 25 and 30 MHz instead of 33 MHz 
(for example: old ones with Pentium 75 (25MHz), 90, 120, 150 (30MHz)), 
the idebus parameter is there to allow the timings to be fine-tuned for 
these machines. Nothing to worry about.

-- 
Lionel Bouton

-
"I wanted to be free. I opensourced my whole DNA code" Gyver, 1999.



