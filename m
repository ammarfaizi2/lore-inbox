Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbSLEMfz>; Thu, 5 Dec 2002 07:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267309AbSLEMfz>; Thu, 5 Dec 2002 07:35:55 -0500
Received: from fetch.runbox.com ([193.71.199.211]:22704 "EHLO aibo.runbox.com")
	by vger.kernel.org with ESMTP id <S267308AbSLEMfy>;
	Thu, 5 Dec 2002 07:35:54 -0500
Message-ID: <002701c29c5c$93fab2c0$47614ccb@zaman>
From: "Shahid" <z-shahid@runbox.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "kernel" <linux-kernel@vger.kernel.org>
References: <00d101c29b8d$63e45e80$4b614ccb@zaman> <1039009659.15359.16.camel@irongate.swansea.linux.org.uk>
Date: Thu, 5 Dec 2002 18:46:21 +0600
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Subject: Re: testing mouse device driver
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Shahid" <z-shahid@runbox.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 04, 2002 7:47 PM
Subject: Re: testing mouse device driver


>
> Minor 0 is dynamic - you probably want to pick another minor number or
> look in /proc/misc to see which minor was chosen.
>
> The PS/2 port is rather special btw and tied in with the keyboard so
> isnt one you can treat seperately. Fortunately no PS/2 mouse should need
> any 2.4 kernel hacks, just user space stuff to handle different command
> streams
>

  /******* Eid Mubarok and greetings to all of this kernel mailing list
                        on the occasion of the Holy Eid
*********/

hi,
        thanx for ur quick response. Actually what i need (a part of my
academic project), is just to comile ur code and load it as a module and
then to see whether the bare mouse specific events occur. but the painful
reality is, i failed to do so. FYI,  i just a sophomore undergraduate
student, and i don't find any resourse inside or outside my faculty to help
me to do this. So i had to come in the kernel mailing list, though i am
almost a newbie.

        i tried with minor numbers other than 0. first i tried with ,inor
number 1, cauze this is the number i got in /proc/misc allocated for psaux,
in that file. but the result is same. now while i try to load the module,
the error message is:

        init_module: no such device, invalid parameters
        hint: invalid IO or irq number


        then i arbitary tried with some other minor numbers, but the result
is same.
So plz help me to just load the module. as u r the author, certainly u
compiled that code and load the module. so plz tell me ur parameters, i.e.
the port address and major-minor number and irq number, or other hints so
that i load that module.
TIK

regards -
Shahid


