Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272668AbRIUJQa>; Fri, 21 Sep 2001 05:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272737AbRIUJQL>; Fri, 21 Sep 2001 05:16:11 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:37367 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S272668AbRIUJQC>; Fri, 21 Sep 2001 05:16:02 -0400
Message-ID: <3BAB0547.9F36DBA5@pp.inet.fi>
Date: Fri, 21 Sep 2001 12:15:51 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "steve j. kondik" <shade@chemlab.org>
CC: "Michael H. Warfield" <mhw@wittsend.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
In-Reply-To: <1000912739.17522.2.camel@discord>
			<3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
			<3BA9DC30.DA46A008@pp.inet.fi> <20010920142555.B588@suse.de>
			<1000991848.569.1.camel@discord> <3BAA21B1.B579D368@pp.inet.fi>
			<1001006425.1498.9.camel@discord> <3BAA2D7F.DBBCFC8C@pp.inet.fi> 
			<20010920145950.I16647@alcove.wittsend.com> <1001032613.31730.3.camel@eris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"steve j. kondik" wrote:
> agreed.  i've had this problem on two seperate systems, however i _am_
> running a few other patches- notably the kpreempt patch.  but again, no
> problems at all until 2.4.10-pre12.  i'll try some things in the morning
> and see what i can come up with.  i see you are doing swapon, however
> have you tried mkswap over your loopdev?  i can actually swapon just
> fine, its mkswap that causes the panic.

I losetup the encrypted swap loop with a random key every time the box
boots, so mkswap is done before swapon. I used the example script in the
loop-AES README file.

For testing purposes, can you back out the kpreempt patch, and let me know
if that cures the problem.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

