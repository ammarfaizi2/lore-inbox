Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129128AbQJ3SDY>; Mon, 30 Oct 2000 13:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbQJ3SDP>; Mon, 30 Oct 2000 13:03:15 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:15623 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129128AbQJ3SDA>; Mon, 30 Oct 2000 13:03:00 -0500
Message-ID: <39FDB6ED.FAFDBEEB@timpanogas.org>
Date: Mon, 30 Oct 2000 10:59:09 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ingo Molnar <mingo@elte.hu>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030025600.B20271@vger.timpanogas.org> <Pine.LNX.4.21.0010301212590.3186-100000@elte.hu> <20001030184109.C21935@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:
> 
> On Mon, Oct 30, 2000 at 12:13:52PM +0100, Ingo Molnar wrote:
> > simple, write a TUX protocol module for it. FTP protocol module is on its
> > way. Stay tuned.
> 
> TUX modules are kernel modules (I mean you have to write kernel space code for
> doing TUX ftp). Don't you agree that zero-copy sendfile like ftp serving would
> be able to perform equally well too? I mean: isn't better to spend the efforts
> to make an userspace API to run fast instead of moving every network
> functionality that needs high performance completly in kernel? People may need
> to write high performance network code for custom protocols, this way they will
> end creating kernel modules with system-crashing bugs, memory leaks and kernel
> buffer overflows (chroot+nobody+logging won't work anymore). (plus they will
> get into pain while debugging)

Ingo's helping me get the info together on this for putting a MARS-NWE
tux module in 
the kernel.  He had to go do some things this week he told me before he
would be ready
to look at it.  He did point me over to the info, and I agreed we would
attempt to 
implement it as something to look at.  If it performs well enough, I
will have 
something reasonable to send out to Novell Resellers (CNEs) and
Cutomers.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
