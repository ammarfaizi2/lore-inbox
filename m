Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289694AbSAWFh3>; Wed, 23 Jan 2002 00:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289697AbSAWFhU>; Wed, 23 Jan 2002 00:37:20 -0500
Received: from nlakdiva.slt.lk ([203.115.0.1]:60156 "EHLO lakdiva.slt.lk")
	by vger.kernel.org with ESMTP id <S289694AbSAWFhO>;
	Wed, 23 Jan 2002 00:37:14 -0500
Message-ID: <3C77C5C5.45359449@sltnet.lk>
Date: Sat, 23 Feb 2002 11:39:33 -0500
From: "Ishan O. Jayawardena" <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kdb on virtual console
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC' TO : ioshadi@sltnet.lk (I'm on the list, my ISP's having some
trouble at 
present.)

Greetings,

        I've seen threads discussing this here in the past, but nothing
seems
to have come out of it. So here goes...

The problem: On exit from a kdb session in linux (with the "go"
command), the 
kernel is resumed (acpid works - i.e. the power button is the only
interface 
left!), but the console seems to be locked in some way. _Sometimes_,
hitting 
the enter key brigs up the shell prompt, but most of the time, nothing.
I don't
have another machine to use kdb on a serial console. Just tried kdb 2.1
with 
linux 2.4.17: still hangs. I've heard that stopping and starting gpm in
the 
background is a workaround, but obviously, it doesn't fix anything.

        I'd be grateful if anyone could provide a real fix or tell me
how I 
should go about the kernel's tty code to find the root of this problem.


        Thanks in advance.

Ishan Oshadi Jayawardena


CC' TO : ioshadi@sltnet.lk
----
        "Premature anger is the sign of an immature mind."
                                        - Destro "G. I. Joe"
        /* Yes, I still watch cartoons. So sue me :) */
