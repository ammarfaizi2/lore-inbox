Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSHZPmj>; Mon, 26 Aug 2002 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSHZPmj>; Mon, 26 Aug 2002 11:42:39 -0400
Received: from mailix.e-technik.uni-ulm.de ([134.60.21.160]:23568 "HELO
	mailix.e-technik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S317005AbSHZPmh>; Mon, 26 Aug 2002 11:42:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kai-Boris Schad <kschad@ebs.e-technik.uni-ulm.de>
Reply-To: kschad@ebs.e-technik.uni-ulm.de
Organization: =?iso8859-15?q?Universit=E4t?= Ulm
To: Tony Nugent <tony@linuxworks.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re:Re: Q: Howto access the keyboard in a linux system without a graphics card ?
Date: Mon, 26 Aug 2002 17:46:30 +0200
X-Mailer: KMail [version 1.3.1]
References: <200208261136.g7QBam501221@hobbit.linuxworks.com.au.nospam>
In-Reply-To: <200208261136.g7QBam501221@hobbit.linuxworks.com.au.nospam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020826154648.821B25CC037@mailix.e-technik.uni-ulm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. August 2002 13:36 schrieben Sie:
> On Mon Aug 26 2002 at 11:43, Kai-Boris Schad wrote:
> > Hi !
> >
> > I'm trying to set up a small embedded system for gps receiving with a
> > linux system.  I want to have the system working without a graphics card
> > - wich works well. The Problem I have at the moment is to access the
> > keyboard without a graphics card, because the console driver does not
> > start then ( Also a redirect doesn't work then :-( )
> > Is there a way to access the keyboard in this case by a user program ?
> > The system recognises the keyboard ( I think Kernel and init) and reacts
> > if ctrl-alt-del is pressed.
> >
> > Thanks for your help !
>
> Why not boot and access it through a serial port?  It is possible to
> get the boot loader, kernel and console access through that, totally
> headless and kdb-less.  The howtos tell you how to it...
>
> > Kai
>
> Cheers
> Tony

O.k. Thanks for the comment, actually I was also thinking about this. The 
problem is that I cannot insert any additional serial ports or interfaces 
(hardware). I have a small PC(PC104 Dimensions) with two serial ports, one 
for a gps modul and the other for a packet radio modem. On the parallel port 
I have a LCD monitor. And a small numberblock keyboard  connected to the 
keyboard connector. With the graphics card everything works fine - the 
problem is that I don't have any room for the card in the box and I really 
don't need it because of the lcd module (execept for the keyboard ;-)).  

Is there any way to tell the console/tty driver to start without a graphics 
card ? 
How does the system recognise the ctrl-alt-del ? (because this works anyway)

Ok I think my task is very special but I wondered a bit because I didn't 
expect the console, or tty drivers to stop without the graphics card. 

I hope there is a solution for this ;-)

Kai

-- 
Kai-Boris Schad 
University of Ulm, Germany
Dept. of Electron Devices and Circuits
Integrated Circuits in Communications
Albert Einstein Allee 45
89069 ULM

http://www.uni-ulm.de/icic
email:kschad@ebs.e-technik.uni-ulm.de
phone +49/731/50-31581  fax +49/731/50-31599
