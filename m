Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281726AbRLKQTR>; Tue, 11 Dec 2001 11:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281772AbRLKQTH>; Tue, 11 Dec 2001 11:19:07 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:49832 "HELO
	mail-smtp.uvsc.edu") by vger.kernel.org with SMTP
	id <S281726AbRLKQSu> convert rfc822-to-8bit; Tue, 11 Dec 2001 11:18:50 -0500
Message-Id: <sc15ce38.053@mail-smtp.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Tue, 11 Dec 2001 09:13:13 -0700
From: "Tyler BIRD" <BIRDTY@uvsc.edu>
To: <jens_krueger@frm2.tu-muenchen.de>, <mj@ucw.cz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PCI Subsystem
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You probably could compile your drivers as modules and load them
with io ports on the command line.  Then they would for sure use the right ports.
I don't know why you aren't receiving the correct io/ports from the PCI Config Address Space
does your driver take advantage of the the PCI standard

>>> Jens Krüger <jens_krueger@frm2.tu-muenchen.de> 12/11/01 05:26AM >>>
Hi, 
I have a little problem with the PCI subsystem. I tried to use two cards of 
the Meilhaus Co.. If I use the PCI access mode 'any' I don't get the right 
I/O ports of the cards. Next I tried the access mode 'Direct' ( the output of 
the lspci -v  command is listed in the attached file lspci.direct) and the 
access mode 'BIOS' (the output is stored in the file lspci.bios). There are 
some little differences in the output, but all seems the same except the 
output of the two Meilhaus cards. I have no idea for this behaviour. I tried 
these cards under DOS and I got the same information as for the BIOS access 
mode (the programm access the BIOS too), but in this mode all other cards 
especially network card and USB don't work, so I can't  use this mode. My 
question: Is there any idea (or hack) to solve this problem? 

With regards 

Jens
-- 

Jens Krnger

Technische UniversitSt Mnnchen
ZBE FRM-II
Lichtenberg-Str. 1
D-85747 Garching

Tel: + 49 89 289 14 716
Fax: + 49 89 289 14 666
mailto:jens_krueger@frm2.tu-muenchen.de 
http://www.frm2.tu-muenchen.de

