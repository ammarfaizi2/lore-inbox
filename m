Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278723AbRJVLZT>; Mon, 22 Oct 2001 07:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278520AbRJVLZJ>; Mon, 22 Oct 2001 07:25:09 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:60403 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S278724AbRJVLY4>;
	Mon, 22 Oct 2001 07:24:56 -0400
Message-ID: <XFMail.20011022132529.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 22 Oct 2001 13:25:29 +0200 (CEST)
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.12: Missing tty when logging in on the console
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after installation of kernel 2.4.12 (migrated from 2.4.10
by "make oldconfig"), having problems when logging in on
a virtual console:

It sems that there is no correct tty attached to the console:

1. the ps command lists _all_ processes actually running under
   the correspondent userid and only those running under
   the login shell.

2. Starting a ssh command for some other box is rejected
   by

                You have no controlling tty and no DISPLAY.
                Cannot read passphrase.

I never had such problems when running 2.4.10 kernel.

Regards
 



Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

