Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281090AbRKYVlk>; Sun, 25 Nov 2001 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281083AbRKYVlU>; Sun, 25 Nov 2001 16:41:20 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:37080
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S281090AbRKYVlL>; Sun, 25 Nov 2001 16:41:11 -0500
Message-ID: <00e001c175fa$90d02b40$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Chris Wedgwood" <cw@f00f.org>, "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3BFFE8A2.1010708@rueb.com> <Pine.LNX.4.10.10111241402420.3696-100000@coffee.psychology.mcmaster.ca> <20011125222313.D9672@weta.f00f.org>
Subject: Re: Disk hardware caching, performance, and journalling
Date: Sun, 25 Nov 2001 14:45:57 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think if you have a large mail server and zero power protection, you've
got much larger problems to worry about than write-behind caching on your
disk drives... my servers have never (in my memory) experienced a
catastrophic power failure, because they're too easy to avoid.

----- Original Message -----
From: "Chris Wedgwood" <cw@f00f.org>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, November 25, 2001 2:23 AM
Subject: Re: Disk hardware caching, performance, and journalling


> On Sat, Nov 24, 2001 at 02:39:44PM -0500, Mark Hahn wrote:
>
>     why does everyone get freaked out about disk caches?  afaikt,
>     there's only an O(50ms) window at each catastrophic power failure:
>     trivial for any reasonable rate of failures...
>
> If your disks are busy all the time (eg. a large mail server) then you
> will trivially hit this and it will be a problem.
>
>
>
>   --cw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

