Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132993AbRDRDYH>; Tue, 17 Apr 2001 23:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132994AbRDRDX6>; Tue, 17 Apr 2001 23:23:58 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16030 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132993AbRDRDXk>;
	Tue, 17 Apr 2001 23:23:40 -0400
Message-ID: <3ADD08B9.EA6D6AD4@mandrakesoft.com>
Date: Tue, 17 Apr 2001 23:23:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ghadi Shayban <ghad@triad.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rw-semaphore regression in 2.4.4-pre4
In-Reply-To: <3ADD07D7.80806@triad.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ghadi Shayban wrote:
> 
> Processes, most easily mozilla, get stuck in the "D" state in
> 2.4.4-pre4.  I don't believe this was fixed in pre2 but now it happens
> again.      Also, just a minor error, but 2.4.4-pre4 modules are put in
> the 2.4.3 directory.  The version number was probably accidentally left
> the same.

Linus is good about rememeber to change the version these days.  This
sounds like a patch/install error on your side...

--- v2.4.3/linux/Makefile       Thu Mar 29 20:13:15 2001
+++ linux/Makefile      Fri Apr 13 20:26:46 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
-SUBLEVEL = 3
-EXTRAVERSION =
+SUBLEVEL = 4
+EXTRAVERSION =-pre4

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
