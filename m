Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130828AbRCJCLJ>; Fri, 9 Mar 2001 21:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbRCJCK7>; Fri, 9 Mar 2001 21:10:59 -0500
Received: from monolith.eradicator.org ([64.81.135.24]:37542 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S130828AbRCJCKt>;
	Fri, 9 Mar 2001 21:10:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: allow notsc option for buggy cpus
In-Reply-To: <E14bY2D-00063q-00@the-village.bc.nu>
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 09 Mar 2001 21:09:47 -0500
In-Reply-To: Alan Cox's message of "Sat, 10 Mar 2001 01:23:37 GMT"
Message-ID: <877l1yxtlg.fsf@monolith.eradicator.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > My IBM Thinkpad 600E changes between 100MHz and 400MHz depending if the
> > power is on. This means gettimeofday goes backwards if you boot with the
> 
> Intel speedstep CPU. 

The 600E's CPU doesn't actually use SpeedStep (it's only a 400MHz
Mobile Pentium2, SpeedStep made its debut with the 600MHz Mobile
Pentium3), but rather some kind of external speed throttling... which
accomplishes basically the same thing, and makes one wonder why Intel
had to go and trademark the idea of incorporating it into the CPU.

Toshiba laptops and probably others have been doing the same thing for
ages now, I once had a Tecra (now sadly deceased) that would throttle
from 133MHz to 66MHz (I think) when unplugged.

I think this behaviour can be controlled with tpctl for the Thinkpads
and possibly with the Toshiba utils on Toshibas...

-- 
David Huggins-Daines              -                     dhd@pobox.com
                      http://www.pobox.com/~dhd/
