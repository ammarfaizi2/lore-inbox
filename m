Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQKCWc2>; Fri, 3 Nov 2000 17:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129034AbQKCWcS>; Fri, 3 Nov 2000 17:32:18 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:14340 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129033AbQKCWcJ>;
	Fri, 3 Nov 2000 17:32:09 -0500
Message-ID: <3A033C82.114016A0@mandrakesoft.com>
Date: Fri, 03 Nov 2000 17:30:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
CC: kuznet@ms2.inr.ac.ru, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, davies@maniac.ultranet.com
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> <200011031937.WAA10753@ms2.inr.ac.ru> <20001103160108.D16644@ganymede.isdn.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Wendling wrote:
> 
> Also sprach kuznet@ms2.inr.ac.ru:
> } > de4x5 is probably also buggy in regard to this.
> }
> } de4x5 is hopeless. I added nice comment in softnet to it.
> } Unfortunately it was lost. 8)
> }
> } Andi, neither you nor me nor Alan nor anyone are able to audit
> } all this unnevessarily overcomplicated code. It was buggy, is buggy
> } and will be buggy. It is inavoidable, as soon as you have hundreds
> } of drivers.
> }
> If they are buggy and unsupported, why aren't they being expunged from
> the main source tree and placed into a ``contrib'' directory or something
> for people who may want those drivers?

de4x5 is stable.  Its hopeless to add stuff to it, or try to any fix of
the (IMHO small) issues, but its fine as is.  For maintenance issues,
its PCI support will be eliminated in 2.5.x because it is a duplicate of
support in the tulip driver.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
