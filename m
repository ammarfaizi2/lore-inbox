Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268102AbTCFNrz>; Thu, 6 Mar 2003 08:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268105AbTCFNry>; Thu, 6 Mar 2003 08:47:54 -0500
Received: from as12-5-6.spa.s.bonet.se ([217.215.177.162]:47024 "EHLO
	www.tnonline.net") by vger.kernel.org with ESMTP id <S268102AbTCFNrw>;
	Thu, 6 Mar 2003 08:47:52 -0500
Date: Thu, 6 Mar 2003 14:58:18 +0100
From: Anders Widman <andewid@tnonline.net>
X-Mailer: The Bat! (v1.63 Beta/6)
Reply-To: Anders Widman <andewid@tnonline.net>
Organization: TNOnline.net
X-Priority: 3 (Normal)
Message-ID: <406624312.20030306145818@tnonline.net>
To: "Sam James" <sam.james@adelphia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entire LAN goes boo  with 2.5.64
In-Reply-To: <68CDBCD4C718204B8E3AE0DE304DDB680154CD85@cdptpaex1.adelphia.com>
References: <68CDBCD4C718204B8E3AE0DE304DDB680154CD85@cdptpaex1.adelphia.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds like a bpdu storm, are you somehow looping the network?

Not  that  I  am aware of.. Running only one 8 port switch. Works good
with the 2.4.x kernels, but not with 2.5.. very odd.

//Anders

> -----Original Message-----
> From: Anders Widman [mailto:andewid@tnonline.net] 
> Sent: Thursday, March 06, 2003 6:02 AM
> To: Erik Hensema
> Cc: linux-kernel@vger.kernel.org; erik@hensema.net
> Subject: Re: Entire LAN goes boo with 2.5.64


>> Anders Widman (andewid@tnonline.net) wrote:
>>> 
>>>>    Hello,
>>> 
>>>>    Trying  out  the  2.5.64  kernel  to try to solve some IDE
> specific
>>>>    problems  with 2.4.x kernels. Now I have another problem. We have
> a
>>>>    Windows LAN and a Windows XP with WinRoute Pro as gateway.
>>> 
>>>>    When  booting  the linux-machine with the 2.5.64 kernel the
> windows
>>>>    machine goes to 100% cpu and the switch (Dlink) goes crazy
> (loosing
>>>>    link, other machines get 100k/s instead of 10-12MiB/s etc).
>>> 
>>>>    I  compiled  the  2.5.64  with  as  few  options  as  possible,
> no
>>>>    netfilter, or IPSec or similar stuff.
>>> 
>>>>    What can be the problem?
>>> 
>>>    Forgot to say I am using a Intel Pro100+ NIC and I have tested
> with
>>>    both the Becker driver and the Intel driver.

>> I've seen something similar [1] happen to a LAN with one Windows XP
>> machine running vcool: http://vcool.occludo.net/ . This is also 
>> available for Linux (http://vcool.occludo.net/VC_Linux.html). Are you
>> running this patch or a similar one?

> Nope, no vcool or anything similar. But it is very odd that the switch
> would go crazy too!

>> [1] all machines were seeing frame errors on packets > 250 bytes; it
>> was a 10 mbit coax lan.

> Using 100mbit switched network.


   



> --------
> PGP public key: https://tnonline.net/secure/pgp_key.txt

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


   



--------
PGP public key: https://tnonline.net/secure/pgp_key.txt

