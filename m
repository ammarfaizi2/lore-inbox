Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276750AbRJPVic>; Tue, 16 Oct 2001 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276751AbRJPViW>; Tue, 16 Oct 2001 17:38:22 -0400
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:33445 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S276750AbRJPViN>; Tue, 16 Oct 2001 17:38:13 -0400
Message-ID: <3BCCA955.796132A3@uu.net>
Date: Tue, 16 Oct 2001 17:40:37 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: pzycrow@hotmail.com
Subject: Re: IDE Controller for toshiba laptops?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many older toshiba's had an IDE controller on board capable of DMA
transfers.  However it did not show up as a PCI device and was part of
toshiba's custom north or southbridge.  I believe it was called
piccolo.  The portege 30x0ct and other satellites, etc. of that time
period come to mind.  I requested and recieved the documentation for
this IDE controller from toshiba.  I'm not much of a driver writer, but
I passed it on to several people that were interested.  I'm not sure
what the status is as I'm not working on them personally.


Alex


------------------------------
pzycrow@hotmail.com said: 
> Is anyone working on a driver for the ide-conttoller on the toshiba 
> laptops? 

This does not make any sense. There is no concept of a Toshiba 
specific IDE controller. For example my laptop a Tecra 780DVD 
from lspci I get 

00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 

Typically all the laptops supported by the Toshiba SMM mode driver 
are all Intel based controllers, or if the laptop is really old are 
generic basic IDE controllers. 

The laptops not supported by the Toshiba SMM mode driver are all 
Texas Instruments chipset IDE controllers as far as I am aware. 

What makes you suspect that there is such a thing as a Toshiba 
IDE controller? 

JAB.
