Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279902AbRKVPiN>; Thu, 22 Nov 2001 10:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279860AbRKVPiC>; Thu, 22 Nov 2001 10:38:02 -0500
Received: from mammut.nsc.liu.se ([130.236.104.31]:48133 "EHLO
	mammut.nsc.liu.se") by vger.kernel.org with ESMTP
	id <S279902AbRKVPhy>; Thu, 22 Nov 2001 10:37:54 -0500
Date: Thu, 22 Nov 2001 16:37:52 +0100 (CET)
From: =?ISO-8859-1?Q?Peter_Kjellstr=F6m?= <cap@nsc.liu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: anyone got the same problem with DIGITAL 21143 network card ?
Message-ID: <Pine.LNX.4.21.0111221620010.25529-100000@mammut.nsc.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have the same problem with atleast 2.4.9 and later (I think
it broke somewhere around 2.4.4). However, in my case there is a fix (not
a practical one though). Simply pull the ethernet cable out and plug it
back in again and it starts working.

I see no errors and the cards signal link and 100fdx.

I currently run 2.4.1 which is ok (tulip version 0.9.13a).

My card is a dlink 500TX detected (2.4.1) like this:


 Linux Tulip driver version 0.9.13a (January 20, 2001)
 PCI: Found IRQ 5 for device 00:09.0
 eth0: Digital DS21143 Tulip rev 65 at 0xbc00, 00:80:C8:F7:14:BA, IRQ 5.


some version info (guessing it broke somewhere around 2.4.4)
2.4.1      tulip-0.9.13a     OK
2.4.4-ac12 tulip-0.9.14e     bad*
2.4.6      tulip-0.9.15-pre6 bad*

* can't reboot the machine in question, but IIRC...


/Peter

On Thu, 22 Nov 2001, Ishak Hartono wrote:
> I tried to compile 2.4.14 and successfully detect the digital 21143
> network
> card, however, i can't ping out
>
> this is just a curiosity, because it works with my 2.2.17 kernel
>
> the reason why i didn't move to 2.4.x yet because i got this problem
> with
> 2.4.5 as well and gave it a try again on 2.4.14 kernel
>
> anyone know what should i check in the system  other than blaming on the
> kernel ?
>
> -Ishak-


