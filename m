Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264073AbRFIHSN>; Sat, 9 Jun 2001 03:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264076AbRFIHSD>; Sat, 9 Jun 2001 03:18:03 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58895 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264073AbRFIHRq>;
	Sat, 9 Jun 2001 03:17:46 -0400
Date: Sat, 9 Jun 2001 04:17:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Sean Hunter <sean@dev.sportingbet.com>
Cc: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <20010606112207.H15199@dev.sportingbet.com>
Message-ID: <Pine.LNX.4.21.0106090415560.14934-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Sean Hunter wrote:

> A working VM would have several differences from what we have in my
> opinion, among which are:
>         - It wouldn't require 8GB of swap on my large boxes
>         - It wouldn't suffer from the "bounce buffer" bug on my
>           large boxes
>         - It wouldn't cause the disk drive on my laptop to be
>           _constantly_ in use even when all I have done is spawned a
>           shell session and have no large apps or daemons running.
>         - It wouldn't kill things saying it was OOM unless it was OOM.

I fully agree these problems need to be fixed. I just wish I
had the time to tackle all of them right now ;)

We should be close to getting the 3rd problem fixed and the
deadlock problem with the bounce buffers seems to be fixed
already.

Getting reclaiming of swap space and OOM fixed is a matter
of time ... I hope I'll have that time in the near future.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

