Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129096AbQKFLMO>; Mon, 6 Nov 2000 06:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbQKFLMF>; Mon, 6 Nov 2000 06:12:05 -0500
Received: from Cantor.suse.de ([194.112.123.193]:38666 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129129AbQKFLL4>;
	Mon, 6 Nov 2000 06:11:56 -0500
Date: Mon, 6 Nov 2000 12:11:53 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <andrewm@uow.edu.au>, Oliver Xymoron <oxymoron@waste.org>,
        barryn@pobox.com, linux-kernel@vger.kernel.org,
        jamal <hadi@cyberus.ca>
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
Message-ID: <20001106121153.A14104@gruyere.muc.suse.de>
In-Reply-To: <3A068C00.272BD5D2@uow.edu.au> <E13sk36-00066o-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13sk36-00066o-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 06, 2000 at 11:02:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 11:02:47AM +0000, Alan Cox wrote:
> >        with the TCP ECN_ECHO and CWR flags set, to indicate
> >        ECN-capability, then the sender should send its second
> >        SYN packet without these flags set. This is because
> 
> Now that is nice. The end user perceived effect is that folks with faulty 
> firewalls have horrible slow web sites with a 3 or 4 second wait for each
> page. The perfect incentive. If only someone could do the same to path mtu
> discovery incompetents.

And it penalizes good guys.
If the host cannot answer to the first SYN for some legitimate reason 
then it'll never be able to use ECN. 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
