Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269409AbRHDBbs>; Fri, 3 Aug 2001 21:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269732AbRHDBb2>; Fri, 3 Aug 2001 21:31:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:48545 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269409AbRHDBbS>;
	Fri, 3 Aug 2001 21:31:18 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 4 Aug 2001 01:31:17 GMT
Message-Id: <UTC200108040131.BAA132795.aeb@vlet.cwi.nl>
To: tomas.f@volny.cz
Subject: Re: Trident 9660 problem
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Franke writes:

: I have following problem: 
: I have an old Olivetti computer as the router. After I upgraded it to 2.4.2 
: kernel (RedHat 7.1), the screen always blanks in the moment when it starts
: to write the boot messages. The screen is completely black and no signal on 
: Hsync/Vsync on VGA conncetor. So the monitor goes to the sleep mode after a 
: while. But the rest of the computer works as usual during this problem.
: Only the video output is disabled. 
: The video chip is reported as "Trident 9660" by both X Windows and
: M$ Windoze.
:
: Is this problem known? 

Yes. It is the kernel writing to port 0x92 to enable the A20 gate.
Find a kernel that doesnt or edit setup.S.

See also
	http://www.win.tue.nl/~aeb/linux/kbd/A20.html

Andries
