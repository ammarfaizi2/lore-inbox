Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273061AbRIIVhg>; Sun, 9 Sep 2001 17:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273064AbRIIVh0>; Sun, 9 Sep 2001 17:37:26 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:54024 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273061AbRIIVhF>; Sun, 9 Sep 2001 17:37:05 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109092317330.16723-100000@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.33.0109092317330.16723-100000@sjoerd.sjoerdnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 09 Sep 2001 17:37:53 -0400
Message-Id: <1000071474.16805.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-09 at 17:23, Arjan Filius wrote:
> After my succes report i _do_ noticed something unusual:
> 
> I'm not sure it's preempt related, but you wanted feedback :)
> 
> Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> Sep  9 23:08:02 sjoerd last message repeated 93 times
> Sep  9 23:08:02 sjoerd kernel: cation failed (gfp=0x70/1).
> Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> Sep  9 23:08:02 sjoerd last message repeated 281 times
> 
> This is at the very moment i make a ppp connection to internet, and
> get/set the time with netdate (for the first time after a reboot).
> I didn't see this a second time (yet).
> 

damn, I was exciting we had solved everything :)

actually, I am not confident of what could cause these results.  the
2.4.10-pre is going through another set of changes it should not, and
one of them concerns exactly what you are reporting.

SO, I suggest two options: try pre6.  I don't have patches yet, but I
will diff them soon.  pre5 should apply fairly cleanly, anyhow.

Even better, try 2.4.9-ac10.  It is what I use, and there seems to be
less reported problems.  Plus, Alan is not messing with all the VM work
Linus is playing with right now.  Patches for 2.4.9-ac10 are available.

Both can be had at:
http://tech9.net/rml/linux/

I am curious if you see the error again, and what seems to cause it, but
honestly there is too much work being done in 2.4.10-pre to figure
things out.

Nevertheless, I will look into it -- keep me posted.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

