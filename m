Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270958AbRIAS1j>; Sat, 1 Sep 2001 14:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271095AbRIAS1a>; Sat, 1 Sep 2001 14:27:30 -0400
Received: from colorfullife.com ([216.156.138.34]:34822 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S270958AbRIAS1R>;
	Sat, 1 Sep 2001 14:27:17 -0400
Message-ID: <3B912895.B1635495@colorfullife.com>
Date: Sat, 01 Sep 2001 20:27:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Nuno Miguel Fernandes Sucena Almeida <slug@aeminium.org>
CC: linux-kernel@vger.kernel.org
Subject: natsemi.c (linux 2.4.9) - Something Wicked happened! 18000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> After
> installing the driver module for this card and connecting with a
> cross-cable to another card (tested with 10Mbps 3com509 and 100Mbps
> IntelPro) after the first ping a get the error:
Which compiler do you use?
gcc-2.95-1 is known to miscompile the current linux driver, and at least
one 2.95-2 prerelease snapshot.

egcs-1.1.2 and gcc-2.96-85 are ok.

I've just stress tested the driver from 2.4.9 - no problems at all. 9
MB/s receive, 7 MB/s send with Cyrix 6x68L 120MHz.

I have a workaround, but probably upgrading gcc is the better solution.

--
	Manfred
