Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267316AbUG1Q7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267316AbUG1Q7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267320AbUG1Q6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:58:21 -0400
Received: from ciistr2.ist.utl.pt ([193.136.128.2]:60834 "EHLO
	ciistr2.ist.utl.pt") by vger.kernel.org with ESMTP id S267307AbUG1Q5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:57:46 -0400
From: Claudio Martins <ctpm@ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Date: Wed, 28 Jul 2004 17:53:45 +0100
User-Agent: KMail/1.6.2
Cc: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       "Bryan O'Sullivan" <bos@serpentine.com>, arjanv@redhat.com
References: <1090989052.3098.6.camel@camp4.serpentine.com> <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com>
In-Reply-To: <20040728145228.GA9316@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407281753.45199.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 28 July 2004 15:52, Dave Jones wrote:
> On Wed, Jul 28, 2004 at 08:53:19AM +0200, Jens Axboe wrote:
>  > On Wed, Jul 28 2004, Edward Angelo Dayao wrote:
>  > > yeah i get this kind of error in my logs as well from my liteon
>  > > dvd-rom at home. thats like 6 months old and happened on fc2 when i
>  > > had that installed on it. haven't noticed anything on mandrake 10 (the
>  > > current distro i use at home) with 2.6.7.
>  > >
>  > > i got the same error on my old notebook, a compaq presario... that was
>  > > prior to the drive being sent to that big junk yard in the sky.  i
>  > > forget what model that was.  but i was running then...  rh9.
>  > >
>  > > hope this bit helps guys resolve this.
>  >
>  > (dont top post!)
>  >
>  > Sounds like something fc2 is doing, I'd suggest filing a bug report with
>  > them.
>
> Curious. The relevant code should match mainline 1:1 there unless I'm
> mistaken. Arjan ?

  I'm having similar problems running vanilla 2.6.7 with Debian-amd64 on an 
Athlon 64 using a Philips DVDR824P. It refuses to read some of my dvd+r discs 
to the end, while some may even refuse to mount. In both cases the errors are 
of the "attempting to access beyond end of device" type. 

Interestingly the same discs on my laptop with 2.6.7 and an LG GCA-4040N 
dvd+rw writer read fine. After some time (and some cd burns later) one of the 
discs which used to give errors on the Philips writer started to read fine 
again, which left me a bit confused.

  Sorry for not being too detailed about system configuration at this time. If 
you have interest in this, I can give more detailed system info and try to 
report as soon as this happens again with the exact error messages. 
Unfortunately I have not yet managed to create a test iso image or similar 
which would reproduce the problem reliably, but I can add that something 
similar also happenned with cdroms.

Best regards

Claudio


