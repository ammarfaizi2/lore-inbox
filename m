Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbSKSRGa>; Tue, 19 Nov 2002 12:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSKSRGa>; Tue, 19 Nov 2002 12:06:30 -0500
Received: from web14604.mail.yahoo.com ([216.136.224.84]:25707 "HELO
	web14604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266962AbSKSRG3>; Tue, 19 Nov 2002 12:06:29 -0500
Message-ID: <20021119165847.58163.qmail@web14604.mail.yahoo.com>
Date: Tue, 19 Nov 2002 08:58:47 -0800 (PST)
From: Super user <lnxuser2002@yahoo.com>
Subject: Killing kernel threads
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any guaranted way to kill kernel threads
started from loadable modules. I've written a kernel
module that starts 8 kernel threads and sometimes one
of them goes into uninterruptible sleep. Is there
anyway to flush away such threads while unloading
modules.

I've tried using kill_proc with SIGKILL but it doesn't
seem to help.

BTW, I am using the code for handling kernel threads
at http://www.scs.ch/~frey/linux/kernelthreads.html

Any pointers regarding the same are highly
appreciated.

Thanks,



__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - Let the expert host your site
http://webhosting.yahoo.com
