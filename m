Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSA0J4r>; Sun, 27 Jan 2002 04:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSA0J4f>; Sun, 27 Jan 2002 04:56:35 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:18948 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287908AbSA0J4X>; Sun, 27 Jan 2002 04:56:23 -0500
Message-ID: <3C53CEC5.1060008@yahoo.com>
Date: Sun, 27 Jan 2002 03:56:21 -0600
From: Chris <volthead@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tulip hangs on 2.4.17
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently run into a problem with the tulip driver on my laptop.

It loads fine at first, and I can get connected to a network, etc.  When 
I reboot the machine, it hangs when it tries to load the tulip module. 
This only happens with a warm reboot, not a cold boot.  It is quite 
repeatable.  If I power off completely, there is no problem.  If I 
comment the tulip driver out of my startup scripts, there is no problem. 
  If I reboot, it hangs.

This does not happen with the 2.4.5 kernel, only the 2.4.17.  These are 
the only  2 I have tried.

I have found that if I bring down my ethernet interface and unload the 
tulip module before the warm reboot, the system will not lock when it 
comes back up, so I have added the neccessary commands to my shutdown 
scripts.  However, it seems to me like a kernel bug that should probably 
be fixed.

My specific hardware/software config is:

HP Pavillion XH555 laptop with:
1 Ghz Athlon 4
512 MB RAM
ESS sound/modem  (sound using Maestro3 driver)
Accton ethernet   (using tulip driver)

Software:
Slackware 8.0, kernel 2.4.17
using ACPI, tulip, maestro3, ext3, framebuffer, etc.

If there's any more info that would help, please let me know.

-Chris


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

