Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEQeT>; Tue, 5 Dec 2000 11:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLEQeK>; Tue, 5 Dec 2000 11:34:10 -0500
Received: from main.cornernet.com ([209.98.65.1]:42255 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S129210AbQLEQd7>; Tue, 5 Dec 2000 11:33:59 -0500
Date: Tue, 5 Dec 2000 10:03:59 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
cc: Steve Hill <steve@navaho.co.uk>, PaulJakma <paulj@itg.ie>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Serial Console
In-Reply-To: <802569AC.0054D7AC.00@notesmta.eur.3com.com>
Message-ID: <Pine.LNX.4.30.0012050951290.11399-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See, in an ideal world, that shouldn't be the case, at all.

Since we're NOT operating under the assumption that the serial console is
a modem, we should be - instead - operating under the assumption
that it is a 3-wire NULL connection. (thus, making NO assumptions about
the user's hardware..)

If the user wants to ADD RTS/CTS flow control or DCD based state checking
as an OPTION, well, hey.  whatever. Pick your poison.  But i sure as hell
wouldn't do it that way.

Chad

> Lilo 'append="console=ttyS0"' and it boots fine without a connection to the
> serial port without having to do any specific manipulation of the flow control.
> I think that all serial output is dumped to /dev/null if DCD is not asserted no
> matter what the flow control says. Perhaps there are some hardware differences
> in the configuration of the control signal pull-up/downs.
>
>      Jon Burgess
>
>
>
>
> PLANET PROJECT will connect millions of people worldwide through the combined
> technology of 3Com and the Internet. Find out more and register now at
> http://www.planetproject.com
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
