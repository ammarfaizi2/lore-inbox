Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278789AbRJ3XpW>; Tue, 30 Oct 2001 18:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278781AbRJ3XpE>; Tue, 30 Oct 2001 18:45:04 -0500
Received: from mail004.mail.bellsouth.net ([205.152.58.24]:59095 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278795AbRJ3Xov>; Tue, 30 Oct 2001 18:44:51 -0500
Message-ID: <3BDF3B97.C7AB6CFE@mandrakesoft.com>
Date: Tue, 30 Oct 2001 18:45:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrea@suse.de
Subject: Re: pre5 VM livelock
In-Reply-To: <Pine.LNX.4.33.0110301527521.1188-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I just want confirmation that you actually did something that could result
> in this, ie you were testing big processes?

yes.  here's meminfo, FWIW:


[jgarzik@brutus jgarzik]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  391372800 217260032 174112768        0 13025280 163340288
Swap: 418996224        0 418996224
MemTotal:       382200 kB
MemFree:        170032 kB
MemShared:           0 kB
Buffers:         12720 kB
Cached:         159512 kB
SwapCached:          0 kB
Active:          39888 kB
Inactive:       137880 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       382200 kB
LowFree:        170032 kB
SwapTotal:      409176 kB
SwapFree:       409176 kB

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

