Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129222AbRBESai>; Mon, 5 Feb 2001 13:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131245AbRBESa2>; Mon, 5 Feb 2001 13:30:28 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:5641 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129222AbRBESaT>;
	Mon, 5 Feb 2001 13:30:19 -0500
Date: Mon, 5 Feb 2001 18:26:52 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Frank de Lange <frank@unternet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010205182652.B604@grobbebol.xs4all.nl>
In-Reply-To: <20010202145216.C13831@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010202145216.C13831@unternet.org>; from frank@unternet.org on Fri, Feb 02, 2001 at 02:52:16PM +0100
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 02:52:16PM +0100, Frank de Lange wrote:
> I'm currently running 2.4.1 with Maciej's patch-2.4.0-io_apic-4. Additionally,
> I disabled focus_processor in apic.c to get rid of some network delays. Flood
> pings both from and to this system do not cause any problems, other than making
> the streaming audio sound a bit choppy...


ok, Franks -- the deal -- I'll re-add the disable foxus stuff; Maciej's
latest apic patch keeps the system working for 2days+ and that  is much
better tahan before., it used to lock up within half a day.

I'll report further. an Maciej -- thanks for your work !

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
