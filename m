Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbSJaUbg>; Thu, 31 Oct 2002 15:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265430AbSJaUbg>; Thu, 31 Oct 2002 15:31:36 -0500
Received: from nwd2mime2.analog.com ([137.71.25.114]:23050 "EHLO
	nwd2mime2.analog.com") by vger.kernel.org with ESMTP
	id <S265429AbSJaUbf>; Thu, 31 Oct 2002 15:31:35 -0500
Message-ID: <3DC1949A.B1B862A1@analog.com>
Date: Thu, 31 Oct 2002 12:37:46 -0800
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial Port Speed Change, 2.4.10->2.4.16
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Probably a dumb question, but I have a MIPS-based system that I'm
running Linux on, and when moving from 2.4.10 kernel to 2.4.16 kernel,
the # of characters per second on the serial console has dropped
significantly. 

The serial port used is a 16450 clone (it's built in to the processor,
so no, I can't upgrade it). It's programmed to run at 9600 baud, 8N1.
There's clearly no problem with the characters themselves. But while I
can push ~1000 CPS under 2.4.10, I can only push ~100 CPS under
2.4.16. I've noticed that the CPS of the console is constant in
2.4.16, regardless of serial port speed. 

Can anyone lend any insight into why I would've lost 90% of my serial
port throughput moving between these two revs of the kernel? 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
