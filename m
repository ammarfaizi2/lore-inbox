Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131578AbRCNXIh>; Wed, 14 Mar 2001 18:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbRCNXI1>; Wed, 14 Mar 2001 18:08:27 -0500
Received: from mail2.adsweu.com ([62.172.160.197]:6672 "EHLO
	ukpava43.adsweu.com") by vger.kernel.org with ESMTP
	id <S131578AbRCNXIJ>; Wed, 14 Mar 2001 18:08:09 -0500
Subject: Re: IBM ServerRAID 4L firmware 4.40.03
To: Robert Grimm <bgrimm@yourmindseye.com>,
        Jérôme Tytgat <j.tytgat@ision.fr>,
        Zing Zing Awungshi Shishak <shishz@alum.rpi.edu>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Pim Zandbergen <P.Zandbergen@macroscoop.nl>
Cc: linux-kernel@vger.kernel.org
From: "Robert Miciovici" <Robert_Miciovici@adsweu.com>
Date: Thu, 15 Mar 2001 01:10:47 +0200
Message-Id: <OFAAC92024.5E0C458D-ONC2256A0F.007E98DB@pav.uk.ema.adsw.net>
X-MIMETrack: Serialize by Router on UKPAVN06/ADSW/A-D(Release 5.0.5 |September 22, 2000) at
 03/14/2001 10:59:35 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------------------- Forwarded by Robert Miciovici/Romania/ADSW/A-D on
03/15/2001 12:42 AM ---------------------------


Robert Miciovici
03/14/2001 11:11 PM

To:   "ServeRAID For Linux" <ipslinux@us.ibm.com>
cc:
Subject:  Re: IBM ServerRAID 4L firmware 4.40.03  (Document link: Robert
      Miciovici)

Hi,
Look what I can provide as further info about my failure to install RH7 on
the Netfinity 5100 with the ServerRAID 4L controller:
I boot in "expert text" mode from the original bootable CD created after
the iso image available on ftp.redhat.com/
and of course I have the IBM ServerRAID for driver for Linux diskette in
the floppy drive

look what I get on one of the installation log screens:

* Cannot find /tmp/drivers/rhdd-6.1; bad driver disk
* Cannot find /tmp/drivers/modinfo; bad driver disk
* Cannot find /tmp/drivers/modules.dep; bad driver disk
* Cannot find /tmp/drivers/pcitable; bad driver disk

and

* trying to mount device /tmp/fd0
* going to insmod ips.o (path is NULL)
/tmp/ips.o: init_module: %m
Hint: this error can be caused by incorrect module parameters, including
invalid IO or IRQ parameters

I also tried mounting the driver floppy and insert the module manually but
I couldn't even mount the floppy in the shell provided by the RH 7.0
install...
Oddly I can install RedHat 6.2 with the same driver diskette on the same
machine anytime.


What do you say, how should I approach this one?

Please help me.

Best regards,
          Robert




"ServeRAID For Linux" <ipslinux@us.ibm.com> on 02/26/2001 08:00:11 PM

To:   "Robert Miciovici" <Robert_Miciovici@adsweu.com>
cc:
Subject:  IBM ServerRAID 4L firmware 4.40.03


Red Hat 7 contains version 4.20 if the ips driver.  It should install on a
ServeRAID 4L ( even without a driver diskette ).     If you want to use the
4.50 driver diskette during install, it also works.   I have installed RH 7
many times using the current ( 4.50 ) diskette and have never seen a
problem.

BTW, Keith left IBM in December.



"Robert Miciovici" <Robert_Miciovici@adsweu.com> on 02/26/2001 12:15:00 PM

To:   Keith Mitchell <ipslinux@us.ibm.com>
cc:
Subject:  IBM ServerRAID 4L firmware 4.40.03


Hi Keith,
I know that you are busy, and I apologise for taking up a little of your
precios time, but I would like to ask you a simple question.
How could I install RedHat 7.0 on a Netfinity 5100 with a IBM ServerRAID 4L
firmware 4.40.03 ?
I already tried with the latest driver diskette but it's not working, says
something like: ips module couldn't be loaded complaining about probably
some incorrect module parameters (which I didn't supply manually and I
don't know what should I).
Btw: RedHat 6.2 installs like a charm with the same drivers diskette.

Thank you,

Best regards,
     Robert

DISCLAIMER: This e-mail contains proprietary information some or all
of which may be legally privileged.  It is for the intended recipient
only. If an addressing or transmission error has misdirected this
e-mail, please notify the author by replying to this e-mail.  If you
are not the intended recipient you must not use, disclose, distribute,
copy, print, or rely on this e-mail.

This message has been scanned for the presence of computer viruses.



This message has been scanned for the presence of computer viruses.






----------------------------------------------------------------------
DISCLAIMER: This e-mail contains proprietary information some or all
of which may be legally privileged.  It is for the intended recipient
only. If an addressing or transmission error has misdirected this 
e-mail, please notify the author by replying to this e-mail.  If you
are not the intended recipient you must not use, disclose, distribute,
copy, print, or rely on this e-mail.

Please note that users should have no expectation that any 
information they transmit or receive over Allied Domecq facilities 
or stored on Allied Domecq computers is or will remain private, and 
Allied Domecq reserves the right to review these records. Allied 
Domecq reserves the right to intercept, monitor and record this e-mail.

This message has been scanned for the presence of computer viruses.
-----------------------------------------------------------------------
