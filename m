Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135517AbRAYMZ7>; Thu, 25 Jan 2001 07:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135499AbRAYMZt>; Thu, 25 Jan 2001 07:25:49 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:7415 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S135517AbRAYMZj>; Thu, 25 Jan 2001 07:25:39 -0500
Date: Thu, 25 Jan 2001 12:25:17 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Andi Kleen <ak@suse.de>, kuznet@ms2.inr.ac.ru,
        Manfred Spraul <manfred@colorfullife.COM>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
In-Reply-To: <14960.3804.197814.496909@pizda.ninka.net>
Message-ID: <Pine.SOL.4.21.0101251224350.651-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, David S. Miller wrote:

> 
> Andi Kleen writes:
>  > It's mostly for security to make it more difficult to nuke connections
>  > without knowing the sequence number.
>  > 
>  > Remember RFC is from a very different internet with much less DoS attacks.
> 
> Andi, one of the worst DoSs in the world is not being able to
> communicate with half of the systems out there.
> 
> BSD and Solaris both make these kinds of packets, therefore it is must
> to handle them properly.  So we will fix Linux, there is no argument.

Hang on... From what was quoted of the RFC, this behaviour (accepting
these packets) isn't required of hosts? In which case, if BSD or Solaris
depend on it, THEY are violating the protocol, not Linux??


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
