Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317241AbSFCBES>; Sun, 2 Jun 2002 21:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317243AbSFCBER>; Sun, 2 Jun 2002 21:04:17 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:57283 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317241AbSFCBER>; Sun, 2 Jun 2002 21:04:17 -0400
Message-ID: <20020603010412.26640.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Anthony Spinillo" <tspinillo@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 03 Jun 2002 09:04:12 +0800
Subject: Re: INTEL 845G Chipset IDE Quandry
X-Originating-Ip: 24.49.78.239
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fired up 2519 as a test, same resource collision problem.

Tony

----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: 	03 Jun 2002 02:13:45 +0100
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: INTEL 845G Chipset IDE Quandry


> On Sun, 2002-06-02 at 22:30, Vojtech Pavlik wrote:
> > On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> > > Anthony Spinillo wrote:
> > > > Back to my original problem, will there be a fix before 2010? ;)
> > > 
> > > Well since you have already tyred yourself to poke at it.
> > > Well please just go ahead and atd an entry to the table
> > > at the end of piix.c which encompasses the device.
> > > Do it by copying over the next familiar one and I would
> > > be really geald if you could just test whatever this
> > > worked. If yes well please send me just the patch and
> > > I will include it.
> > 
> > Note it works with 2.5 already. We have the device there.
> 
> If you look at why it fails it fails not because it isnt in the table
> but because the PCI device has not been allocated resources properly by
> the BIOS
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
