Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290445AbSAQUgI>; Thu, 17 Jan 2002 15:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290446AbSAQUf6>; Thu, 17 Jan 2002 15:35:58 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:48654 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290445AbSAQUfp>; Thu, 17 Jan 2002 15:35:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 17 Jan 2002 12:42:01 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alexander Viro <viro@math.psu.edu>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: bread() seems reading bogus data ...
In-Reply-To: <Pine.GSO.4.21.0201171523430.11155-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.40.0201171241370.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Alexander Viro wrote:

>
>
> On Wed, 16 Jan 2002, Davide Libenzi wrote:
>
> >
> >
> > Linus,
> >
> > it seems that __bread() read wrong data on my disk resulting in a ext2
> > magic of 0x8001 ?!?, reading from /dev/hda5 03:05
> > Below is reported a dmesg from my machine when booted with 2.5.2
> > Are you able to guess something or do i need to drill more ?
>
> Which version?

Fixed by Jens ata patch.



- Davide


