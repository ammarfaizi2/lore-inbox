Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDKYu>; Sat, 4 Nov 2000 05:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbQKDKYk>; Sat, 4 Nov 2000 05:24:40 -0500
Received: from nwcst283.netaddress.usa.net ([204.68.23.28]:56771 "HELO
	nwcst283.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S129033AbQKDKYg> convert rfc822-to-8bit; Sat, 4 Nov 2000 05:24:36 -0500
Message-ID: <20001104102435.19069.qmail@nwcst283.netaddress.usa.net>
Date: 4 Nov 00 15:54:35 IST
From: Nitin Dhingra <nitin.d@usa.net>
To: linux-kernel@vger.kernel.org
Subject: A little help in SCSI Device Drivers
X-Mailer: USANET web-mailer (34FM.0700.4.03)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Respected Sir,
I had got your mail from redhat.com and came to know you are 
working under drivers in Linux. I am also working in this field,
I would like you to help me out with one problem as I am stuck here
and couldn't proceed further.

I am working in a project that involves making a low-level device 
driver for a SCSI card (Symbios Logic sym 53c810) and the problem 
that I am facing is with interrupts. There is a kind of a script 
processor in the card to which we give some instructions to interrupt
and the IRQ line 10 is supposed to be interrupted. Now the problem 
is we request irq 10 and provide our ISR entry, but this ISR is never
called infact when we check /proc/interrupts or /proc/stat, there is
"0" value infront of our entry.

I have verified that interrupt has occured in the SCSI as I had 
polled and found out. Now I am not able to get where could be the 
problem as the interrupt is ocuuring from SCSI side and also the card
is working fine that I have checked. 

Could you suggest some possible solution to this?

I would be awaiting your precious suggestion.

Thanks,

Regards,
Nitin Dhingra


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
