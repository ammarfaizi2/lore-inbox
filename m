Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAPOLg>; Tue, 16 Jan 2001 09:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbRAPOL0>; Tue, 16 Jan 2001 09:11:26 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:8462 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129436AbRAPOLN>; Tue, 16 Jan 2001 09:11:13 -0500
Message-ID: <3A64567C.2054AF01@Hell.WH8.TU-Dresden.De>
Date: Tue, 16 Jan 2001 15:11:08 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Process hung in "D" state with 2.2.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've got a sendmail 8.1.11 process hanging in D state with 2.2.18.

ps -eo fname,tty,pid,stat,pcpu,nwchan,wchan  reveals the following:

  PID STAT %CPU  WCHAN WIDE-WCHAN-COLUMN COMMAND 
16176 D     0.0 1f4c28 down_failed       sendmail: startup with ...

Is this likely a bug in the kernel or in sendmail? Also let me
know what additional info I could provide to help track down the
bug.

Regards,
Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
