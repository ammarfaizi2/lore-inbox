Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbRDZJhw>; Thu, 26 Apr 2001 05:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135251AbRDZJhd>; Thu, 26 Apr 2001 05:37:33 -0400
Received: from [195.6.125.97] ([195.6.125.97]:43277 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S135249AbRDZJh3>;
	Thu, 26 Apr 2001 05:37:29 -0400
Date: Thu, 26 Apr 2001 11:34:51 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Fw: Re: Fw: where can I find the IP address ?
Message-Id: <20010426113451.0868493d.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Début du message transféré :

Date: Wed, 25 Apr 2001 16:45:48 +0200
From: sébastien person <sebastien.person@sycomore.fr>
To: Helge Hafting <helgehaf@idb.hist.no>
Subject: Re: Fw: where can I find the IP address ?


Le Wed, 25 Apr 2001 15:17:59 +0200
Helge Hafting <helgehaf@idb.hist.no> à écrit :

> sébastien person wrote:
> > 
> > Début du message transféré :
> > 
> > Date: Tue, 24 Apr 2001 16:43:18 +0200
> > From: sébastien person <sebastien.person@sycomore.fr>
> > To: liste noyau linux <linux-kernel@vger.kernel.org>
> > Subject: where can I find the IP address ?
> > 
> > I'm dealing with a driver wich need the IP address for specifics using.
> > 
> The IP address of what?
> Rememeber, a computer can have an arbitrary number of different
> IP addresses assigned to various interfaces.  It may even have
> several IP addresses on the same network card.
> 
> So, which of them do you want?
> 
> Helge Hafting

Yes that's right. In fact (excuse my bad english), my driver is 'iconfiged- up' with an
IP in a script, and there is only one IP attach to the adapter. The adapter is a serial
modem wich will work like an ethernet card, I'm working on the encapsulation of packets
on the serial line and I need the IP that ifconfig attach to it.

I've seen in the rubini linux device driver that it exists one field in the struture
that contain the IP but it doesn't exist in my structure so I though that I can find it
elsewhere. So the IP that I need for the driver of the device, is the one the device is
attached to. I expect to explain myself clearly else don't hesitate to tell me more.

thanks

sebastien person

