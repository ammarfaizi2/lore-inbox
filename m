Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTAJOiR>; Fri, 10 Jan 2003 09:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTAJOiR>; Fri, 10 Jan 2003 09:38:17 -0500
Received: from ealliance.ro ([213.233.121.14]:33693 "HELO ealliance.ro")
	by vger.kernel.org with SMTP id <S265097AbTAJOiP> convert rfc822-to-8bit;
	Fri, 10 Jan 2003 09:38:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Mihnea Balta <dark_lkml@mymail.ro>
To: linux-kernel@vger.kernel.org
Subject: Kernel hooks just to get rid of copy_[to/from]_user() and syscall overhead?
Date: Fri, 10 Jan 2003 16:45:39 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301101645.39535.dark_lkml@mymail.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have to implement a system which grabs udp packets off a gigabit connection, 
take some basic action based on what they contain, repack their data with a 
custom protocol header and send them through a gigabit ethernet interface on 
broadcast.

I know how to do this in userspace, but I need to know if doing everyting in 
the kernel would show a considerable speed improvement due to removing 
syscall and memory copy overhead. The system will be quite stressed, having 
to deal with around 15-20000 packets/second.

I didn't want to start this e-mail with an excuse, so I delayed it until here 
:). I appologise if this isn't the right place to ask, it seemed that way to 
me. I wasn't able to find sufficient and coherent information about this 
issue on the internet or on this mailing list's archives, so I decided to ask 
you people directly.

Thanks for your time,
Mihnea Balta

