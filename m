Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310135AbSCPTEs>; Sat, 16 Mar 2002 14:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310402AbSCPTEi>; Sat, 16 Mar 2002 14:04:38 -0500
Received: from [203.162.56.202] ([203.162.56.202]:1732 "HELO
	mail.vnsecurity.net") by vger.kernel.org with SMTP
	id <S310135AbSCPTEX>; Sat, 16 Mar 2002 14:04:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: MrChuoi <MrChuoi@yahoo.com>
Reply-To: MrChuoi@yahoo.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre3-ac1
Date: Sun, 17 Mar 2002 02:14:12 +0700
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E16mITL-0006q5-00@the-village.bc.nu>
In-Reply-To: <E16mITL-0006q5-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020316190415.38CE14E534@mail.vnsecurity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to reproduce on my test computer at work (with nearly the same
configuration). And here it is:

Before loading JBuilder:
        total:    used:    free:  shared: buffers:  cached:
Mem:  129900544 127242240  2658304        0  5947392 79597568
Swap: 67100672        0 67100672
MemTotal:       126856 kB
MemFree:          2596 kB
MemShared:           0 kB
Buffers:          5808 kB
Cached:          77732 kB
SwapCached:          0 kB
Active:          75716 kB
Inact_dirty:     35972 kB
Inact_clean:      5844 kB
Inact_target:    23504 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126856 kB
LowFree:          2596 kB
SwapTotal:       65528 kB
SwapFree:        65528 kB
Committed_AS:    57252 kB

After loading JBuilder:
        total:    used:    free:  shared: buffers:  cached:
Mem:  129900544 125386752  4513792        0  1351680 35352576
Swap: 67100672  2256896 64843776
MemTotal:       126856 kB
MemFree:          4408 kB
MemShared:           0 kB
Buffers:          1320 kB
Cached:          33128 kB
SwapCached:       1396 kB
Active:          86072 kB
Inact_dirty:     29344 kB
Inact_clean:      1060 kB
Inact_target:    23292 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126856 kB
LowFree:          4408 kB
SwapTotal:       65528 kB
SwapFree:        63324 kB
Committed_AS:   226160 kB

HTH,

MrChuoi

On Sunday 17 March 2002 01:00 am, Alan Cox wrote:
> > Free Mem: ~3MB
> > Free Swap: ~64MB
> > Cache: ~32Mb
>
> I need to know the Committed_AS value, the others don't really help
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
