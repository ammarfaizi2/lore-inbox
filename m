Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280948AbRKCMf0>; Sat, 3 Nov 2001 07:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280949AbRKCMfQ>; Sat, 3 Nov 2001 07:35:16 -0500
Received: from mail.spylog.com ([194.67.35.220]:36815 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S280948AbRKCMfI>;
	Sat, 3 Nov 2001 07:35:08 -0500
Date: Sat, 3 Nov 2001 15:35:01 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.12 and memory (Swap<->Cached)
Message-ID: <20011103153501.A26174@spylog.ru>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.


#cat /proc/meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  2108588032 2105348096  3239936        0    69632 708489216
Swap: 4293378048 156639232 4136738816
MemTotal:      2059168 kB
MemFree:          3164 kB
MemShared:           0 kB
Buffers:            68 kB
Cached:         691876 kB
SwapCached:          8 kB
Active:         490884 kB
Inactive:       201068 kB
HighTotal:     1703872 kB
HighFree:         1152 kB
LowTotal:       355296 kB
LowFree:          2012 kB
SwapTotal:     4192752 kB
SwapFree:      4039784 kB



Why use swap, if "Cached" (it is disk cache?) 691876 kB?

-- 
bye.
Andrey Nekrasov, SpyLOG.
