Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129420AbQJ3SFo>; Mon, 30 Oct 2000 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbQJ3SFe>; Mon, 30 Oct 2000 13:05:34 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:17159 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129420AbQJ3SF2>; Mon, 30 Oct 2000 13:05:28 -0500
Message-ID: <39FDB775.45E5653C@timpanogas.org>
Date: Mon, 30 Oct 2000 11:01:25 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Evans <chris@scary.beasts.org>
CC: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010301755210.26279-100000@ferret.lmh.ox.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Evans wrote:
> 
> On Mon, 30 Oct 2000, Andrea Arcangeli wrote:
> 
> > functionality that needs high performance completly in kernel? People
> > may need to write high performance network code for custom protocols,
> > this way they will end creating kernel modules with system-crashing
> > bugs, memory leaks and kernel buffer overflows (chroot+nobody+logging
> > won't work anymore). (plus they will get into pain while debugging)
> 
> I'm glad _someone_ is connected to reality with regards the security
> implications of throwing loads of servers into kernel space.
> 

If we implement a ring 0 Linux, all of this will remain intact with the
need to 
port modules into the kernel at all.  

Jeff

> Cheers
> Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
