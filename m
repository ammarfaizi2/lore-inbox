Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131581AbQLZATr>; Mon, 25 Dec 2000 19:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131549AbQLZATi>; Mon, 25 Dec 2000 19:19:38 -0500
Received: from felix.convergence.de ([212.84.236.131]:20238 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S131401AbQLZATU>;
	Mon, 25 Dec 2000 19:19:20 -0500
Date: Tue, 26 Dec 2000 00:48:43 +0100
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
Message-ID: <20001226004843.A6103@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001226002944.A6058@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20001226002944.A6058@convergence.de>; from leitner@convergence.de on Tue, Dec 26, 2000 at 12:29:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Felix von Leitner (leitner@convergence.de):
> Here is the result of my test program on the strip set:
>   # rb < /dev/md/0
>   30.3 meg/sec
>   #

One more detail: top says the CPU is 50% system when reading from either
one of the disk or raid devices.  That seems awfully high considering
that the Promise controller claims to do UDMA.

Any comments?

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
