Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273189AbRITRFP>; Thu, 20 Sep 2001 13:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274565AbRITRFF>; Thu, 20 Sep 2001 13:05:05 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:23967 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S273189AbRITRE6>; Thu, 20 Sep 2001 13:04:58 -0400
Message-ID: <3BAA21B1.B579D368@pp.inet.fi>
Date: Thu, 20 Sep 2001 20:04:49 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "steve j. kondik" <shade@chemlab.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
In-Reply-To: <1000912739.17522.2.camel@discord>
			<3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
			<3BA9DC30.DA46A008@pp.inet.fi>  <20010920142555.B588@suse.de> <1000991848.569.1.camel@discord>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"steve j. kondik" wrote:
> loop-aes does not work to encrypt swap using 2.4.10-pre12.  the same
> panic results during mkswap.

Did you remove _any_ of the kernel compile time generated files from kernel
source tree? Some of those generated files are _required_ to correctly
compile modules.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

