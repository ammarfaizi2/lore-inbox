Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276659AbRJBUK1>; Tue, 2 Oct 2001 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276660AbRJBUKS>; Tue, 2 Oct 2001 16:10:18 -0400
Received: from [195.66.192.167] ([195.66.192.167]:21769 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S276659AbRJBUKA>; Tue, 2 Oct 2001 16:10:00 -0400
Date: Tue, 2 Oct 2001 23:09:31 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1091577748.20011002230931@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
In-Reply-To: <3BBA1409.6AAA553D@welho.com>
In-Reply-To: <Pine.LNX.4.33.0110022110070.21544-100000@vela.salleURL.edu>
 <3BBA1409.6AAA553D@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday, October 02, 2001, 9:22:49 PM,
Mika Liljeberg <Mika.Liljeberg@welho.com> wrote:

ML> Carles Pina i Estany wrote:
>> The Kernel works fine. But for error I execute /usr/src/linux/vmlinux as
>> root user. Then the system is rebooted (without unmounting anything)
>> 
>> Curious.

ML> And like a headstrong child, I refused to believe, instead thrusting my
ML> finger into the fire.
ML> Ouch! Curious indeed.

Come on guys, that can't be true! Linux can't fail that miserably!
Look:

# su user
$ ./vmlinux
Segmentation fault
*** screen went blank, then POST screen appears ***

Eh... Oh... So... it actually can.   8-(

Straced vmlinux does not reboot.
Kernel: 2.4.10+ext3+preempt
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


