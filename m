Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131966AbRANVEF>; Sun, 14 Jan 2001 16:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132799AbRANVD4>; Sun, 14 Jan 2001 16:03:56 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:63250 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131966AbRANVDi>; Sun, 14 Jan 2001 16:03:38 -0500
Date: Sun, 14 Jan 2001 16:04:31 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Urban Widmark <urban@teststation.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000
In-Reply-To: <Pine.LNX.4.30.0101141132100.22034-100000@cola.teststation.com>
Message-ID: <Pine.LNX.4.31.0101141505470.935-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Urban Widmark wrote:

>> eth1: Transmit timed out, status 0000, PHY status 0000,
>> resetting...
>[snip]
>> Keeps going nonstop until I ifdown eth1.
>>
>> Card worked fine 2 days ago...
>
>So what did you change?

Nothing.

>Has the machine been up since then?

No.  I rebooted to W98 a few times.  W98 doesn't have a driver
installed for that card though - and wont.



>Someone else with the same symptoms (in 2.4)
>    http://www.uwsg.iu.edu/hypermail/linux/net/0011.0/0027.html
>
>Becker's reply
>    http://www.uwsg.iu.edu/hypermail/linux/net/0011.0/0032.html
>
>"Try unplugging the system and doing a really cold boot. A soft-off does
> not reset the chip.

Tried that too.. didn't work.  I switched PCI slots and whatnot
though and it works again..  <shrug>


> If this solves the problem, we will have to add code to re-load the
> EEPROM info into the chip."

If the problem recurs I will try to test it out more and report
to the list.

FWIW it is a DLink DFE 530TX.

Thanks for the reply.

----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

#[Mike A. Harris bash tip #1 - separate history files per virtual console]
# Put the following at the bottom of your ~/.bash_profile
[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
tty |grep "^/dev/tty[0-9]" >& /dev/null && \
        export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
