Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275856AbRJULqP>; Sun, 21 Oct 2001 07:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJULqF>; Sun, 21 Oct 2001 07:46:05 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:51472 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275861AbRJULpu>; Sun, 21 Oct 2001 07:45:50 -0400
Date: Sun, 21 Oct 2001 14:46:10 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org, cdwrite@other.debian.org
Subject: Re: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
Message-ID: <20011021144610.G1504@niksula.cs.hut.fi>
In-Reply-To: <200110211137.f9LBb1w08887@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110211137.f9LBb1w08887@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Sun, Oct 21, 2001 at 01:37:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 01:37:01PM +0200, you [Joerg Schilling] claimed:
> 

Thanks for the timely reply!

> This must be a broken drive....

Hmm. It used to work with 2.2-kernel. With too large image, it just gave an
error.
 
> >a short while, the whole system locked up, no mouse, keyboard, caps lock,
> >ctrl-alt-del, alt-sysrq-{s,u,b}.
> 
> This is a broken kernel!

Yep.
 
> >It used to give a nice error when disk size was exceeded with 2.2.18pre19
> >and a tad older cdrecord (1.9-something (1.10-4 failed on 2.2 BTW, giving
> >error on mmapping /dev/null)).
> 
> Don't use outdated cdrecord versions, I cannot support them!

Ok. I updated to 1.10 from redhat rawhide, but as said it didn't work at all
with 2.2 ("failed to mmap /dev/null" or something) so I went back to 1.9. I
could retry now that I've updated the machine in question to 2.4. (I can
also see if the 2.2 /dev/null error reproduces if you are interested.) I'll
retry too large image with 1.10 and report back to you, but I fear it is a
kernel bug.
 
> http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/problems.html
>
> 1.9 is outdated for a long long time, it obviously cannot contain workarounds
> for Linux kernel bugs introduced after cdrecord-1.9 came out.

;)
 
> It looks like there is still a timeout bug in the kernel.
> If the kernel handles timeouts correctly, then cdrecord will return.

I see.


-- v --

v@iki.fi
