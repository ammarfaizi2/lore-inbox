Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRKVSA7>; Thu, 22 Nov 2001 13:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280948AbRKVSAt>; Thu, 22 Nov 2001 13:00:49 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:8651 "EHLO
	c0mailgw09.prontomail.com") by vger.kernel.org with ESMTP
	id <S280132AbRKVSAi>; Thu, 22 Nov 2001 13:00:38 -0500
Message-ID: <3BFD3C37.7C5BCCC4@starband.net>
Date: Thu, 22 Nov 2001 12:56:07 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166wSm-00063a-00@mauve.csi.cam.ac.uk> <3BFD2997.95F2B9EE@starband.net> <E166xr9-0000Qy-00@mauve.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is incorrect.
SWAP is used on a [1GB ram/2GB swap system].

I talked to Rik about this.
He said generally SWAP is a good thing and increases performance.

However, in my case it does not.

Nov 22 12:18:41 <war> riel: For a single user system.
Nov 22 12:18:43 <ata> war: what are you trying to do ?
Nov 22 12:18:44 <riel>  war: it all depends on what you use the computer for
Nov 22 12:18:56 <riel>  war: that's a very important thing to specify ;)
Nov 22 12:18:57 <war> General X apps, staroffice/netscape/media
stuff(aviplay)/etc
Nov 22 12:19:06 <war> compiling apps once and awhile
Nov 22 12:19:13 <riel>  war: ok, in that case you omost likely don't need swap
Nov 22 12:19:32 <riel>  war: but you really _need_ to tell what you are using
the computer for before anybody can give a sensible answer ;)
Nov 22 12:19:43 <war> riel: thats what I thought too, yet people still say I do
even after I told them what I was using it for
Nov 22 12:19:52 <ata> learath: nope 1gb will still win just one app will loose
and die
Nov 22 12:19:54 <war> riel: I sent the list of my ps auxww (512 processes) and
I still had 350MB left over.
Nov 22 12:20:05 <riel>  war: yup, I saw that



James A Sutherland wrote:

> On Thursday 22 November 2001 4:36 pm, war wrote:
> > The bottom line here is:
> >
> > There is no need for swap if you have enough ram.
> > Using swap with more than enough ram does absolutley nothing for the
> > system, except by degrading the performance of it.
>
> If the system has so much RAM that EVERYTHING fits in RAM - programs, data
> and FS cache - then the swap won't be touched anyway, and makes no
> difference. This is rather unlikely on a PC; in practice, adding swap should
> always improve matters. (Of course, the VM isn't perfect yet...)
>
> James.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

