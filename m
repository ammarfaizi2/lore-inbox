Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135867AbRDYOs4>; Wed, 25 Apr 2001 10:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135868AbRDYOsg>; Wed, 25 Apr 2001 10:48:36 -0400
Received: from [195.6.125.97] ([195.6.125.97]:2054 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S135867AbRDYOsc>;
	Wed, 25 Apr 2001 10:48:32 -0400
Date: Wed, 25 Apr 2001 16:45:48 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: Fw: where can I find the IP address ?
Message-Id: <20010425164548.3767d2cb.sebastien.person@sycomore.fr>
In-Reply-To: <3AE6CE87.9F9A1DA7@idb.hist.no>
In-Reply-To: <20010425143636.038539aa.sebastien.person@sycomore.fr>
	<3AE6CE87.9F9A1DA7@idb.hist.no>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

