Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280992AbRKGVO4>; Wed, 7 Nov 2001 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280995AbRKGVNi>; Wed, 7 Nov 2001 16:13:38 -0500
Received: from ns1ca.ubisoft.qc.ca ([205.205.27.131]:32006 "EHLO
	ns1ca.ubisoft.qc.ca") by vger.kernel.org with ESMTP
	id <S280989AbRKGVMo>; Wed, 7 Nov 2001 16:12:44 -0500
Message-ID: <9A1957CB9FC45A4FA6F35961093ABB8405491190@srvmail-mtl.ubisoft.qc.ca>
From: Patrick Allaire <pallaire@gameloft.com>
To: "Bradley D. LaRonde" <brad@ltc.com>,
        Patrick Allaire <pallaire@gameloft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Irq problems : [ Kernel booting on serial console ... crawling]
Date: Wed, 7 Nov 2001 16:11:05 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thank you for you answer ... I think my interrupt are not working ... I have
added a printk line in my interrupt routine, it is called every 1000 jiffies
!!!! if I do a cat /proc/interrupts ... once completed (c: I see that I dont
receive any interrupt on IRQ 4 ... it is alwais 0 ... but the serial is
registered.

thank again !



Patrick Allaire
mailto:pallaire@gameloft.com
If you can see it, but it's not there, it's virtual. 
If you can't see it, but it is there, it's hidden. 
It you can't see it and it isn't there, it's gone.



> -----Original Message-----
> From: Bradley D. LaRonde [mailto:brad@ltc.com]
> Sent: November 6, 2001 5:11 PM
> To: Patrick Allaire; Linux Kernel Mailing List
> Subject: Re: Kernel booting on serial console ... crawling
> 
> 
> I've seen something like that when my serial driver wasn't getting
> interrupts.
> 
> Regards,
> Brad
> 
> "Patrick Allaire" <pallaire@gameloft.com> said:
> > I tried to boot my kernel using the serial console, using the
> > console=ttyS0,115200 (it does the same thing with 9600) ... 
> it work great
> > until :
> >
> > Freeing unused kernel memory: 36k freed
> > serial console detected.  Disabling virtual terminals.
> > console=/dev/ttyS0
> >
> > At this point the output of the serial line slow down dramaticly ...
> almost
> > to a halt ... I get 1 line every 30 seconds !!!
> 
