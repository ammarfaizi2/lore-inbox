Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154116AbPGVCTA>; Wed, 21 Jul 1999 22:19:00 -0400
Received: by vger.rutgers.edu id <S154035AbPGVCSj>; Wed, 21 Jul 1999 22:18:39 -0400
Received: from gw.simegen.com ([203.2.135.4]:4450 "EHLO gw.simegen.com") by vger.rutgers.edu with ESMTP id <S153976AbPGVCSb>; Wed, 21 Jul 1999 22:18:31 -0400
Message-ID: <37967F3F.5F3CC5A1@zeor.simegen.com>
Date: Thu, 22 Jul 1999 12:17:35 +1000
From: Dancer <dancer@zeor.simegen.com>
X-Mailer: Mozilla 4.6 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Y. Ts'o" <tytso@mit.edu>
CC: Lars Kellogg-Stedman <lars@bu.edu>, Nomad the Wanderer <nomad@orci.com>, linux-kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: Device naming???
References: <199907212041.QAA10609@tsx-prime.MIT.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

"Theodore Y. Ts'o" wrote:
> 
> The other solution for avoiding problems if a specific SCSI drive fails
> to spin up is to use entries in /etc/fstab of the following form:
> 
> LABEL=tmp              /tmp                     ext2    defaults 1 2
> UUID=3a30d6b4-08a5-11d3-91c3-e1fc5550af17  /usr ext2    defaults 1 2
> 
> The latest mount supports this, as does the very latest e2fsprogs
> release (1.15, just released this week; see the e2fsprogs page at
> http://web.mit.edu/tytso/www/linux/e2fsprogs.html).

Where's the UUID stored? On the drive? Wouldn't this cause problems with
systems involving hot-swap drives? (Ie: If a scratch drive fails (as
many have), and I go 'eek!', swap it and reboot, the drive UUID would be
different and I'd also have to edit the fstab, right?)

Just checking...for my own information.

D

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
