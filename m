Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTDQA5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbTDQA5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:57:03 -0400
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:1797 "EHLO
	maunzelectronics.com") by vger.kernel.org with ESMTP
	id S262120AbTDQA47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:56:59 -0400
Message-ID: <3E9DFEA5.F3F22E79@justirc.net>
Date: Wed, 16 Apr 2003 21:08:53 -0400
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ac97, alc101+kt8235 sound
References: <Pine.LNX.4.44.0304150537330.28926-100000@q.dyndns.org> <1050406611.27745.34.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are on this subject...

I tried this kernel about 2 days ago, and had unexpected results at times.
1. the kernel would lock up, and so dead that not even the sysrq key did
anything (I usually turn that debugging stuff on)
2. it would work, but more than 1 application accessing the sound would cause
the kernel or give it up and once again, lock up.
3. it would just lock up the second app trying to gain access to the sound.
I do not have any output from the kernel, it crashed that hard (why..?)
first thing I did was apply the 2.4.21 pre patch, then the -ac patch to a
2.4.20 tree, this right?
anyone has any ideas on getting this to work right, and have at least more
than 1 application access the card, let me know.
im trying to get quake + teamspeak to co-exist.


Alan Cox wrote:

> On Maw, 2003-04-15 at 12:49, Benson Chow wrote:
> > hoping that these via chips were pretty close.  Unfortunately no, it
> > still doesn't work.  It did, however, find the AC97 codec fine (I added
> > some printk's), but no sound is produced.  Any ideas on how to get this
> > vt8235-based motherboard sound working?  (and ALSA-0.9.2 seems to do
> > nothing but segfault it seems.)
>
> See 2.4.21pre - that has the driver for VIA8233/5
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Regards,
Mark Rutherford
mark@justirc.net

PGP key: http://www.justirc.net/~mark/markrutherford.asc
fingerprint: 1CF2 6229 306D A2C8 2C89  46BE FFD6 D910 5170 4FA9


