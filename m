Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAOQlu>; Mon, 15 Jan 2001 11:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAOQll>; Mon, 15 Jan 2001 11:41:41 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:17682 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129401AbRAOQl0>; Mon, 15 Jan 2001 11:41:26 -0500
From: Wayne.Brown@altec.com
X-Lotus-FromDomain: ALTEC
To: Jeff Chua <jchua@fedex.com>
cc: Alan Shutko <ats@acm.org>, linux-kernel@silk.corp.fedex.com,
        jchua@fedex.com
Message-ID: <862569D5.005B7D66.00@smtpnotes.altec.com>
Date: Mon, 15 Jan 2001 10:38:15 -0600
Subject: Re: linmodem????
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Great!  Thanks, Alan and Jeff, for the information.  This works for me, too, on
a Thinkpad 600X.





Jeff Chua <jchua@fedex.com> on 01/15/2001 10:07:57 AM

To:   Alan Shutko <ats@acm.org>
cc:   Wayne Brown/Corporate/Altec@Altec, linux-kernel@silk.corp.fedex.com,
      jchua@fedex.com

Subject:  Re: linmodem????



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
