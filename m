Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272325AbRIKIa3>; Tue, 11 Sep 2001 04:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272330AbRIKIaS>; Tue, 11 Sep 2001 04:30:18 -0400
Received: from ktirunilai.blr.novell.com ([164.99.144.243]:14342 "EHLO
	ktirunilai.blr.novell.com") by vger.kernel.org with ESMTP
	id <S272325AbRIKIaG>; Tue, 11 Sep 2001 04:30:06 -0400
Date: Tue, 11 Sep 2001 14:04:38 +0530 (IST)
From: trkannan76 <trkannan76@myrealbox.com>
X-X-Sender: <trkannan76@ktirunilai.blr.novell.com>
To: <linux-kernel@vger.kernel.org>
cc: <trkannan76@myrealbox.com>
Subject: ps -ef hangs on linux-2.4.9
Message-ID: <Pine.LNX.4.33.0109111357330.3538-100000@ktirunilai.blr.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
       I am running a multithreaded daemon on the 2.4.9 kernel. One of
the threads of the daemon is getting a SIGSEGV. After this when I tried to
find the process state using the command:
   $ ps -ef
   This just hangs, Ctrl-C or Ctrl-Z also does not interrupt this. The
only option I have is to reboot machine.
   When I did a strace on the same command, I found out that ps -ef , was
hanging when it tried to read from the /proc/<pid of killed daemon>/*.
   Is there any way I can reset the /proc directory without rebooting the
machine. After this , even the killall -9 does not work , even this
command hangs.
   Any help will be of real great value. Thank you for the help.

Regards,
Kannan

