Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131345AbRC0OmD>; Tue, 27 Mar 2001 09:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRC0Oly>; Tue, 27 Mar 2001 09:41:54 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:54537 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131345AbRC0Olm>;
	Tue, 27 Mar 2001 09:41:42 -0500
Date: Tue, 27 Mar 2001 16:40:57 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: kernel apm code
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-laptop@vger.kernel.org, apm@linuxcare.com.au,
        apenwarr@worldvisions.ca, sfr@canb.auug.org.au
Message-id: <3AC0A679.DFA9F74B@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel ( 2.4.2-ac26 or 2.4.3-pre8 ) has 
arch/i386/kernel/apm.c version 1.14 while version 1.15
is available as a patch to 2.3.99-pre7-1  ( read :
it was available for ages ) at http://linuxcare.com.au/apm/

The newer version has among other things support for
the APM_IOC_REJECT ioctl which is useful for example
when implementing "run /sbin/shutdown -h when the power
button is pressed".

While isn't this merged into the official kernel ?

Is apm.c v1.15 the latest ?
The last modification of the http://linuxcare.com.au/apm/ page
was in may 2000 and in 2.4.2-ac25 the web address for the APM driver
was changed to http://www.canb.auug.org.au/~sfr/ , but that page
doesn't have much/any content about the APM driver.


On a related note :
Both Abit BH6 and MSI K7T Pro2A send a SYSTEM_SUSPEND APM event
( APM_SYS_SUSPEND ) when I press the power button. When the OS
acknowledges the event, the system doesn't go to suspend , as
the OS expects , but to power-off , killing all running processes
and causing an unclean umount , among other things.

Is this the APM standard behavior or do I have two weird motherboards ?


P.S.: Looking for an archive of the linux-laptop@vger.kernel.org
mail list.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
