Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143982AbRAHPkp>; Mon, 8 Jan 2001 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143953AbRAHPkf>; Mon, 8 Jan 2001 10:40:35 -0500
Received: from mcdc-us-smtp4.cdc.gov ([198.246.97.20]:3848 "EHLO
	mcdc-us-smtp4.cdc.gov") by vger.kernel.org with ESMTP
	id <S143992AbRAHPk1>; Mon, 8 Jan 2001 10:40:27 -0500
Message-ID: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7FA5@mcdc-atl-5.cdc.gov>
X-Sybari-Space: 00000000 00000000 00000000
From: Heitzso <xxh1@cdc.gov>
To: "'Greg KH'" <greg@wirex.com>, Heitzso <xxh1@cdc.gov>
Cc: "'antirez@invece.org'" <antirez@invece.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: RE: USB broken in 2.4.0
Date: Mon, 8 Jan 2001 10:38:31 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a flurry of emails I haven't read yet.
I wanted to answer the direction question first

 test9 OK
 test10 OK
 test11 BROKEN

so that's where the break occurred.

I've gotta admit I was scared running the older
test kernels because somewhere in the series
the filesystem could be damaged and it bit me
bad on the first pass a couple of months ago.
I compiled the kernels under current full 2.4.0
and when rebooting to the test kernels tried
to get in, do the test, and get out as fast
as possible.

Heitzso


-----Original Message-----
From: Greg KH [mailto:greg@wirex.com]
Sent: Friday, January 05, 2001 1:01 PM
To: Heitzso
Cc: 'antirez@invece.org'; 'linux-kernel@vger.kernel.org'; 'Johannes
Erdfelt'
Subject: Re: USB broken in 2.4.0


On Fri, Jan 05, 2001 at 12:38:25PM -0500, Heitzso wrote:
> I just tested with fresh-out-of-the-box
> 2.4.0 and using the newer libusb 0.1.2 
> as suggested by antirez  (see email chain
> below for more info).  I compiled libusb
> and s10sh code this AM under 2.4.0. 
> 
> It blows up BAD by finding increasingly
> larger photo images in the camera over
> the usb link and extracting them to disk.
> So by the third file you're trying to
> extract gig sized files.  Obviously the
> filesystem files up, the sytem chokes, etc.
> 
> This is the same code that works fine
> under 2.2.18 kernel (I use it all of the
> time there).

I made the same request to Jordan Mendelson yesterday, who has the same
problem.  Could you be so kind as to try to narrow down which kernel
version this broke on?  I have reports that it used to work on -test9
but doesn't now.  Could you try -test10, etc and let me know?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
