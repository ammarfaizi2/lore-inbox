Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSJ3BH2>; Tue, 29 Oct 2002 20:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbSJ3BH2>; Tue, 29 Oct 2002 20:07:28 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:23815
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262547AbSJ3BH0>; Tue, 29 Oct 2002 20:07:26 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C7C@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Alex Pavloff'" <apavloff@eason.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: RE: what serial port type are Elan ports?
Date: Tue, 29 Oct 2002 17:13:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks, I think the Elan SC520 is all I need. I don't know if the other
chips in the family have the same bug. 

There is a conflict between the Elan work-around and the 16C654 UART. It
looks like the work-around causes it to drop transmit data. If I can know
for sure the detected type of the Elan's ports, then I can shield all other
UART types from the work-around with a quick type field check without losing
the benefit of the work-around. 

Suggestions are welcome.

Best regards,
Ed

> -----Original Message-----
> From: Alex Pavloff [mailto:apavloff@eason.com]
> Sent: Tuesday, October 29, 2002 4:19 PM
> To: 'Ed Vance'; 'linux-kernel'; 'linux-serial'
> Subject: RE: what serial port type are Elan ports?
> 
> 
> 
> Elan Sc3x0?
> Elan Sc4x0?
> Elan Sc520?
> 
> I assume you mean the 520, if you really want to find the 
> UART for the SC3x0
> I might be convinced to plug in a hard drive to one of my 
> many SC320s lying
> around and let you know.
> 
> Alex Pavloff - apavloff@eason.com
> Eason Technology -- www.eason.com
> 
> > -----Original Message-----
> > From: Ed Vance [mailto:EdV@macrolink.com]
> > Sent: Tuesday, October 29, 2002 4:14 PM
> > To: 'linux-kernel'; 'linux-serial'
> > Subject: what serial port type are Elan ports?
> > 
> > 
> > Hi,
> > 
> > I need to know what UART type the serial driver detects for 
> > the two built-in
> > serial ports on the AMD Elan Microcontroller?
> > 
> > Would some nice person who has an Elan based system please 
> > send me the first
> > ten lines of the output of the following command?
> > 
> > 	more /proc/tty/driver/serial
> > 
> > Thanks in advance,
> > Ed
> > 
> > ---------------------------------------------------------------- 
> > Ed Vance              edv (at) macrolink (dot) com
> > Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> > ----------------------------------------------------------------
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-serial" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
