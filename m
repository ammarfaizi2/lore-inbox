Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVBXDDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVBXDDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVBXDDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:03:54 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:12459 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261689AbVBXDDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:03:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XK7Fikem3/4m4zctW6Ki93hZpZPiZtktl7bBY3Qcu87dpR1zGyie3C5CSxwvD/3Yzz1Zdpn2yIiQ7+XfsPzCyCoMU1EtFGn/I3SJqeNjf97WVMVvCj5M6851WHpD+rjYYV43/RsWZpTYzPKWne6IBH++lzGC/8CUzi6LWAO2Fns=
Message-ID: <29495f1d050223114865257aad@mail.gmail.com>
Date: Wed, 23 Feb 2005 11:48:26 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: intel8x0: no sound in 2.6.11 rc3 & 4 (fine with 2.6.10)
Cc: uaca@alumni.uv.es, linux-kernel@vger.kernel.org,
       Tomas Szepe <szepe@pinerecords.com>
In-Reply-To: <421CDA08.3090602@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050219121157.GA14437@pusa.informat.uv.es>
	 <421CDA08.3090602@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005 14:31:20 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> uaca@alumni.uv.es wrote:
> > Hello
> >
> > I have read a post in lkml.org that states that the problem experienced in
> > rc3 has gone (1). That is not the case for me.
> >
> > My audio device is
> >
> > 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)

<snip>

> > I have found that I had to Mute __both__ "Headphone Jack Sense" and
> > "Line Jack Sense" in order to ear the audio in rc4.
> 
> I keep seeing this advice, but what tool do you use to mute them? I
> don't see anything like that in alsamixer, aumix, or any other program I
> tried.

I have a T41p with: Multimedia audio controller: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01),
which looks to the be the same as Ulisses' device.

It works fine for me in 2.6.11-rc4 (has worked fine for a while, as
well). I have both a "Headphone Jack Sense" and "Line Jack Sense"
(both set to off) mixer entry in alsamixer. I'm not sure why you're
not seeing these entries...

Thanks,
Nish
