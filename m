Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275124AbTHGGuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 02:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275125AbTHGGuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 02:50:51 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:56142 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S275124AbTHGGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 02:50:51 -0400
Message-ID: <3F31F6FD.8030001@sbcglobal.net>
Date: Thu, 07 Aug 2003 01:51:41 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ACPI Power Button Event problems(?)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having an interesting, and relatively benign problem with ACPI 
events.  I downloaded the ACPI daemon from SourceForge and with 
2.6.0-test1-mm2 when I pressed the power button, ACPI would be deluded 
with PWRF events until I pushed the button again or acpid was 
restarted.  That's easy enough to work around, but with 2.6.0-test2-mm1 
the events never stop.  Restarting the daemon makes no difference, nor 
does pushing the button have any effect.  That wouldn't be too big of a 
problem if I was using the power button to restart the PC, but I'm using 
the event to kill sawfish since it likes locking up (and disregarding 
any keyboard input) leaving me with no recourse but to press the reset 
button otherwise.  So, it works great for the first lockup, but I can't 
reset the power button event so I'm stuck with the reset button on the 
second round.  Unless I want to reboot, which I'd rather not. 

Is this a bug in 2.6.0-test2-mm1 or was the bug the fact it could be 
cancelled in 2.6.0-test1-mm2?

Thanks,

-Wes-

