Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSINOqn>; Sat, 14 Sep 2002 10:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSINOqn>; Sat, 14 Sep 2002 10:46:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:45042 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317073AbSINOqn> convert rfc822-to-8bit; Sat, 14 Sep 2002 10:46:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
Date: Sat, 14 Sep 2002 16:51:00 +0200
User-Agent: KMail/1.4.2
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209131830560.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209131830560.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209141651.00974.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Friday 13 September 2002 23:33, Rik van Riel wrote:
> On Fri, 13 Sep 2002, Pavel Machek wrote:
> > Allocating memory is pain because I have to free it afterwards. Yep I
> > have such code, but it is ugly. try_to_free_pages() really seems like
> > cleaner solution to me... if you only tell me how to fix it :-).
>
> "Fixing" the VM just so it behaves the way swsuspend wants is
> out. If swsuspend relies on all other subsystems playing nicely,
> I think it should be removed from the kernel.

> I suspect only very few people will use swsuspend, so it should
> not be intrusive.

By now, it's only used by a minority (those, who get it going reliably),
but I bet, things change, when 2.6 is out. I would love and even celebrate
once swsuspend is working via nbd for my diskless setups. I consider
this as a real quantum leap (from a usability/energy saving point of view).

The question is: why is the VM not able to fulfill such a simple need in
a clean way?

> regards,
>
> Rik

Regards,
Hans-Peter
