Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbQLESky>; Tue, 5 Dec 2000 13:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130573AbQLESko>; Tue, 5 Dec 2000 13:40:44 -0500
Received: from columba.EUR.3Com.COM ([161.71.169.13]:417 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id <S130568AbQLESkb>; Tue, 5 Dec 2000 13:40:31 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Chad Schwartz <cwslist@main.cornernet.com>
cc: Steve Hill <steve@navaho.co.uk>, PaulJakma <paulj@itg.ie>,
        linux-kernel@vger.kernel.org
Message-ID: <802569AC.00645161.00@notesmta.eur.3com.com>
Date: Tue, 5 Dec 2000 18:09:30 +0000
Subject: Re: Serial Console
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yes it could be a modem on the line, so my comment about DCD is wrong, a comms
program must be able to send AT commands to the modem when DCD is not asserted
before the call is setup. I was being confused by the login getty which we run
on the same serial port. This drops back to the login prompt if it sees DCD
being dropped.

     Jon




PLANET PROJECT will connect millions of people worldwide through the combined
technology of 3Com and the Internet. Find out more and register now at
http://www.planetproject.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
