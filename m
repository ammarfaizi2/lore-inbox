Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317902AbSGWBpr>; Mon, 22 Jul 2002 21:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSGWBpr>; Mon, 22 Jul 2002 21:45:47 -0400
Received: from 205-158-62-37.outblaze.com ([205.158.62.37]:1551 "HELO
	ws1-9.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317902AbSGWBpq>; Mon, 22 Jul 2002 21:45:46 -0400
Message-ID: <20020723014850.80864.qmail@mail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Ana Yuseepi" <anayuseepi@asia.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jul 2002 20:48:50 -0500
Subject: Re: ATA with SMART
X-Originating-Ip: 210.159.65.4
X-Originating-Server: ws1-9.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, first of all, thank you for your replies.. :)

All of the reply I received asked me to take a look at the smartsuite program. I have already taken a look at those, but those doesn't help my problem. It had a support for RETURN_SMART_STATUS command, but only the status_register is returned. The value in cylinder_high and cylinder_low is not returned. So, this is of no use to me.

Any other idea? 

Thanks a lot,

-Ana





----- Original Message -----
From: Dima Brodsky <dima@cs.ubc.ca>
Date: Mon, 22 Jul 2002 07:44:06 -0700
To: Ana Yuseepi <anayuseepi@asia.com>
Subject: Re: ATA with SMART


> Hi,
> 
> Take a look at the smartsuite set of utilities:
> 
> http://sourceforge.net/projects/smartsuite/
> 
> They are used to control the SMART functionality of a
> drive.  There is probably example code there to do what
> you want.
> 
> ttyl
> Dima
> 
> On Mon, Jul 22, 2002 at 01:24:02AM -0500, Ana Yuseepi wrote:
> > Hello everyone,
> >  
> > I would like to send some SMART commands in linux. One of the command I'd like to send is return_smart_status and I needed some extra data that the device would return in Cylinder_Low and Cylinder_High registers. 
> >  
> > I have tried to use the HDIO_DRIVE_CMD, but I think this can't help me with the above operation.
> >  
> > I tried using the inw_p and outw_p, inb_p, outb_p, but with these, i usually receive the "lost interrupt" message.
> >  
> > Does anyone here have suggestions on what i should do?
> > 
> > Please reply, and thank you for your time,
> > 
> > -Ana
> 
> 
> -- 
> Dima Brodsky                                   dima@cs.ubc.ca
>                                                http://www.cs.ubc.ca/~dima
> 201-2366 Main Mall                             (604) 822-9156 (Office)
> Department of Computer Science                 (604) 822-2895 (DSG Lab)
> University of British Columbia, Canada         (604) 822-5485 (FAX)
> 
> "The price of reliability is the pursuit of the utmost simplicity.
>  It is a price which the very rich find the most hard to pay."
> 						  (Sir Antony Hoare, 1980)
> 
> 

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8

