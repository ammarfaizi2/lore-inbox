Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKCX7q>; Fri, 3 Nov 2000 18:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKCX7g>; Fri, 3 Nov 2000 18:59:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6150 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129033AbQKCX7V>;
	Fri, 3 Nov 2000 18:59:21 -0500
Message-ID: <3A0350EC.8B1A3B4D@mandrakesoft.com>
Date: Fri, 03 Nov 2000 18:57:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, davies@maniac.ultranet.com
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> <200011031937.WAA10753@ms2.inr.ac.ru> <20001103160108.D16644@ganymede.isdn.uiuc.edu> <3A033C82.114016A0@mandrakesoft.com> <20001104004129.C5173@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> de4x5 is stable, but tends to perform badly under load, mostly because
> it doesn't use rx_copybreak and overflows standard socket buffers with its
> always MTU sized skbuffs.

One of the reasons that de4x5 isn't gone already is that I get reports
that de4x5 performs better than the tulip driver for their card.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
