Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277530AbRJVEom>; Mon, 22 Oct 2001 00:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277540AbRJVEod>; Mon, 22 Oct 2001 00:44:33 -0400
Received: from destructo.gearboxsoftware.com ([12.37.36.2]:21777 "HELO
	gearboxsoftware.com") by vger.kernel.org with SMTP
	id <S277532AbRJVEoO>; Mon, 22 Oct 2001 00:44:14 -0400
From: "Sean Cavanaugh" <seanc@gearboxsoftware.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: The new X-Kernel !
Date: Sun, 21 Oct 2001 23:44:48 -0500
Message-ID: <000901c15ab4$4783fd10$150a10ac@gearboxsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <E15vQWb-00085J-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well this thread is sort of a silly argument to begin with, seeing as
all my Linux machines except one don't even have monitors attached to
them :)

I can argue the other side of the fence just as easily . . .
The messages can be handy for figuring out what piece of hardware or
kernel service is taking ages to load when one of them suddenly decides
to take an unusually long time start.  Try piecing that kind of
information out of a dmesg output.  I would rather see
'system/module foo loading . . .' 
'     module specific startup information (stuff we already see in
startup'
'system/module foo loaded in .xxx seconds'

Also ,I also wouldn't really advocate hiding the messages anyway, since
there are thousands of areas elsewhere (outside of the Kernel) to spend
time on and improve usability which would have more of a real impact to
users.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Sunday, October 21, 2001 4:53 PM
To: Sean Cavanaugh
Cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !


> Normal users really don't need to see the startup message spam on 
> boot, unless there is an error (at which point it should be able to 
> present the error to the user).  Any kind of of progress indicator' s 
> really

The big problem is making sure they then see the error, and the previous
progress information. On a solid hang they might not get it

> more for feedback that the boot is proceeding ok.  The fact the boot 
> sequence isn't even interactive should also be a big hint that it 
> isn't really necessary (except for kernel and driver developers).

You are thinking the small picture not the big one. If you are going to
graphical in init then you want to make full use of the graphical
environment to clearly show things like parallel fsck behaviour, what
servers are starting up (with pretty icons) and to do interactive things

like starting a rescue shell, going single user, pausing the boot,
changing run level, interactive boot.

Alan

