Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbRAOPM7>; Mon, 15 Jan 2001 10:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130230AbRAOPMt>; Mon, 15 Jan 2001 10:12:49 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:48908 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129562AbRAOPMe>; Mon, 15 Jan 2001 10:12:34 -0500
Date: Tue, 16 Jan 2001 00:07:57 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Alan Shutko <ats@acm.org>
cc: <Wayne.Brown@altec.com>, <linux-kernel@silk.corp.fedex.com>,
        <jchua@fedex.com>
Subject: Re: linmodem????
In-Reply-To: <87ae8s2a5e.fsf@wesley.springies.com>
Message-ID: <Pine.LNX.4.31.0101160000500.732-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, yes, yes.

ftp'ed ltmodem-5.78d from http://walbran.org/sean/linux/stodolsk

compiled without error on 2.4.1-pre2, but "ltinst" failed to
install on 2.4

You'll have to fix ltinst for 2.4 by modifying this line ...

        cp ltmodem.o /lib/modules/`uname -r`/kernel/drivers/char


Tested on IBM 240Z and it's running ok.

# cu -l ttyLT0
Connected.

ati
LT V.90 Data+Fax Modem Version 5.78

OK


Thanks,

Jeff.


Thanks,
Jeff Chua
[ jchua@fedex.com ]

On 15 Jan 2001, Alan Shutko wrote:

> Wayne.Brown@altec.com writes:
>
> > I haven't, and in fact keep a 2.2.14 kernel available (and in my
> > lilo config) just so I can use the linmodem binary.  It's a pain
> > having to reboot when I want to use the modem, but it's the only
> > solution I've found.
>
> http://walbran.org/sean/linux/stodolsk/
>
> Haven't tried it, but it claims to work.
>
> --
> Alan Shutko <ats@acm.org> - In a variety of flavors!
> Advice from an old carpenter: measure twice, saw once.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
