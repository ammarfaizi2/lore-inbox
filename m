Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbRAZQUm>; Fri, 26 Jan 2001 11:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135316AbRAZQUc>; Fri, 26 Jan 2001 11:20:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135268AbRAZQUW>; Fri, 26 Jan 2001 11:20:22 -0500
Message-ID: <3A71A3AE.DE587EEE@transmeta.com>
Date: Fri, 26 Jan 2001 08:19:58 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <Pine.LNX.3.95.1010126085110.265A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> I will change the port on my machines and run them for a week. I
> don't have any DEC Rainbows or other such. Yes, I know Linux will
> not run on a '286.
> 
> Since 0x19 is a hardware register in a DMA controller, specifically
> called a "scratch" register, it is unlikely to hurt anything. Note
> that the BIOS saves stuff in CMOS. It never expects hardware registers
> to survive a "warm boot". It even checks in CMOS to see if it should
> preserve RAM.
> 

Actually, what you need to do is change it and then try it on something
like 300 different systems.  Since noone has direct access to that kind
of system, you have to get people to help you out trying it.

A better idea might be to find out what port, if any, Windows uses.  If
Windows does it, it is usually safe.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
