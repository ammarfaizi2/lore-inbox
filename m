Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbQKTCC5>; Sun, 19 Nov 2000 21:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQKTCCr>; Sun, 19 Nov 2000 21:02:47 -0500
Received: from adonis.lbl.gov ([128.3.5.144]:14596 "EHLO adonis.lbl.gov")
	by vger.kernel.org with ESMTP id <S129960AbQKTCCl>;
	Sun, 19 Nov 2000 21:02:41 -0500
To: Gerhard Mack <gmack@innerfire.net>
Cc: Martin Mares <mj@suse.cz>, Steven Walter <srwalter@hapablap.dyn.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: "No IRQ known for interrupt pin A..." error message
In-Reply-To: <Pine.LNX.4.10.10011191617420.21113-100000@innerfire.net>
From: Alex Romosan <romosan@adonis.lbl.gov>
Date: 19 Nov 2000 17:32:39 -0800
In-Reply-To: <Pine.LNX.4.10.10011191617420.21113-100000@innerfire.net> (message from Gerhard Mack on Sun, 19 Nov 2000 16:18:43 -0800 (PST))
Message-ID: <873dgnfmx4.fsf@adonis.lbl.gov>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack <gmack@innerfire.net> writes:

> That looks exactly like the message I get if I tell the bios not to
> assign an interrupt to my video card.
> 

unfortunately, i don't get such a choice. and if what you say is true,
isn't the message ("No IRQ known for interrupt pin A of device
05:00.0. Please try using pci=biosirq") misleading? to me this means
the kernel couldn't find the irq by itself, so it will ask the bios.
but if the irq is not assigned in the bios, how can kernel find it
then? maybe i should look at the code itself to try to understand what
is going on here (chances are i won't understand the code anyway, so
that's why i'm asking).


--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
