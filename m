Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132903AbRAHLhk>; Mon, 8 Jan 2001 06:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133002AbRAHLha>; Mon, 8 Jan 2001 06:37:30 -0500
Received: from [203.200.144.37] ([203.200.144.37]:51209 "HELO
	nest.stpt.soft.net") by vger.kernel.org with SMTP
	id <S132903AbRAHLhY>; Mon, 8 Jan 2001 06:37:24 -0500
Organization: NeST India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A55476E7@pdc2.nestec.net>
From: MOHAMMED AZAD <mohammedazad@nestec.net>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: WaitForSingleObject in linux????..
Date: Mon, 8 Jan 2001 17:04:55 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am porting a NT driver and app into linux... Currently i am having a
problem in the application part... The scenario is as follows..

I have a function foo(param1, timeout)... what this function has to do is
wait for param1 to be set true.. ie wait for this varibale to be set till
the timeout expires.. so if the timeout expires before this varibale is set
it will retrun a TIMEDOUT return value... otherwise a success....  The value
of param1 is set by the driver.....(a async processing).

In NT this can be done with a single API call for waitForSingleObject....
how do i do this in LINUX.... Should i go for the timer?? ... or say
implement this via a thread and all??... any suggestion or pointers where to
look???? i would like to have a method which is efficient ie of less cpu
usage.. pls help...

thanks in advance
azad 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
