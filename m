Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131406AbRAYLk5>; Thu, 25 Jan 2001 06:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbRAYLkr>; Thu, 25 Jan 2001 06:40:47 -0500
Received: from Cantor.suse.de ([194.112.123.193]:42508 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131406AbRAYLkj>;
	Thu, 25 Jan 2001 06:40:39 -0500
Date: Thu, 25 Jan 2001 12:40:36 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, kuznet@ms2.inr.ac.ru,
        Manfred Spraul <manfred@colorfullife.COM>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010125124036.A15952@gruyere.muc.suse.de>
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com> <200101242003.XAA21040@ms2.inr.ac.ru> <20010124215634.A2992@gruyere.muc.suse.de> <14960.3804.197814.496909@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14960.3804.197814.496909@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 03:32:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 03:32:44AM -0800, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > It's mostly for security to make it more difficult to nuke connections
>  > without knowing the sequence number.
>  > 
>  > Remember RFC is from a very different internet with much less DoS attacks.
> 
> Andi, one of the worst DoSs in the world is not being able to
> communicate with half of the systems out there.

If it was that serious then there would be surely more reports ;)

> 
> BSD and Solaris both make these kinds of packets, therefore it is must
> to handle them properly.  So we will fix Linux, there is no argument.

How do you propose to handle them? Queue the data anyways or just process
the ACK?


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
